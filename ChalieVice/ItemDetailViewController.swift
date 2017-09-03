//
//  ItemDetailViewController.swift
//  ChalieVice
//
//  Created by nakazumi_hiroyuki on 2017/09/02.
//  Copyright © 2017年 LiveArts. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

var MyObservationContext = 0

class ItemDetailViewController: UIViewController, UIPopoverPresentationControllerDelegate {
  
  public var jsonDetailData: JSON?
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var darkBackground: UIView!
  @IBOutlet weak var webView: UIWebView!
  @IBOutlet weak var webViewHeightConstraint: NSLayoutConstraint!
  
  var observing = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    getItem()

    nameLabel.text = jsonDetailData!["name"].stringValue
    
    let price: String = (jsonDetailData?["price"].stringValue)!
    if price != "" {
      let i = Int(price)
      let num = NSNumber(value: i!)
      
      let formatter = NumberFormatter()
      formatter.numberStyle = NumberFormatter.Style.decimal
      formatter.groupingSeparator = ","
      formatter.groupingSize = 3
      
      let result = formatter.string(from: num)
      
      priceLabel.text = result! + "円 (税込)"
    }
    
    let imgUrlString: String? = jsonDetailData?["image_url"][0].stringValue
    if let url = imgUrlString {
      if url != "" {
        imageView.image = try! UIImage(data: Data(contentsOf: URL(string: url)!))
      }
    }
    
    let htmlString: String = "<style>* {font-family: \"ヒラギノ明朝 ProN W6\"!important }</style>"
    let desc: String = "<h3>説明</h3>" + jsonDetailData!["description"].stringValue
    let detail: String = "<br><h3>詳細情報</h3>" + jsonDetailData!["detail"].stringValue
    webView.loadHTMLString(htmlString + desc + detail, baseURL: nil)
    webView.scrollView.isScrollEnabled = false
    
    let vc: ItemDetailPageViewController = storyboard!.instantiateViewController(withIdentifier: "ItemDetailPageViewController") as! ItemDetailPageViewController
    vc.jsonDetailData = jsonDetailData
  }
  
  func getItem() {
    var keepAlive = true
    
    print("https://chalie-vice-api.herokuapp.com/chalie_vice/items/" + (jsonDetailData?["id"].stringValue)! + ".json")
    Alamofire.request("https://chalie-vice-api.herokuapp.com/chalie_vice/items/" + (jsonDetailData?["id"].stringValue)! + ".json")
      .responseJSON { response in
        guard let object = response.result.value else {
          return
        }
        self.jsonDetailData = JSON(object)
        keepAlive = false
    }
    
    let runLoop = RunLoop.current
    while keepAlive &&
      runLoop.run(mode: RunLoopMode.defaultRunLoopMode, before: NSDate(timeIntervalSinceNow: 0.1) as Date) {
    }
  }
    
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func showDetail() {
    performSegue(withIdentifier: "showItemDetailPopup", sender: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showItemDetailPopup" {
      if let controller = segue.destination.popoverPresentationController {
        controller.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        controller.sourceView = self.view
        controller.sourceRect = CGRect(x: UIScreen.main.bounds.width * 0.5 - 400, y: UIScreen.main.bounds.height * 0.5 - 200, width: 800, height: 300)
        segue.destination.preferredContentSize=CGSize(width: 800, height: 300)
        controller.delegate = self
        darkBackground.alpha = 0.5
        (segue.destination as! ItemDetailPopupViewController).jsonDetailData = jsonDetailData
      }
    }
  }
  
  func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
    darkBackground.alpha = 0.0
  }
  
  deinit {
    stopObservingHeight()
  }
  
  func startObservingHeight() {
    let options = NSKeyValueObservingOptions([.new])
    webView.scrollView.addObserver(self, forKeyPath: "contentSize", options: options, context: &MyObservationContext)
    observing = true;
  }
  
  func stopObservingHeight() {
    webView.scrollView.removeObserver(self, forKeyPath: "contentSize", context: &MyObservationContext)
    observing = false
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    guard let keyPath = keyPath else {
      super.observeValue(forKeyPath: nil, of: object, change: change, context: context)
      return
    }
    switch keyPath {
    case "contentSize":
      if context == &MyObservationContext {
        webViewHeightConstraint.constant = webView.scrollView.contentSize.height
      }
    default:
      super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
    }
  }
}

extension ItemDetailViewController: UIWebViewDelegate {
  func webViewDidFinishLoad(_ webView: UIWebView) {
    webViewHeightConstraint.constant = webView.scrollView.contentSize.height
    if (!observing) {
      startObservingHeight()
    }
  }
}
