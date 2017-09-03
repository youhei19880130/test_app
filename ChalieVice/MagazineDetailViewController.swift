//
//  MagazineDetailViewController.swift
//  ChalieVice
//
//  Created by nakazumi_hiroyuki on 2017/09/01.
//  Copyright © 2017年 LiveArts. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class MagazineDetailViewController: UIViewController, UIPopoverPresentationControllerDelegate {
  
  public var from: String?
  public var jsonData: JSON?
  public var jsonDetailData: JSON?
  @IBOutlet weak var webView: UIWebView!
  @IBOutlet weak var darkBackground: UIView!
  @IBOutlet weak var backButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getItem()

    var htmlString: String = jsonDetailData!["body"].stringValue
    htmlString = "<style>* {font-family: \"ヒラギノ明朝 ProN W6\"!important }</style>" + htmlString
    webView.loadHTMLString(htmlString, baseURL: nil)
    
    switch from! {
    case "top":
      backButton.setTitle(" < TOP に戻る", for: .normal)
    case "magazine":
      backButton.setTitle(" < MAGAZINE に戻る", for: .normal)
    case "event":
      backButton.setTitle(" < EVENT に戻る", for: .normal)
    default:
      backButton.setTitle(" < MAGAZINE に戻る", for: .normal)
    }
  }
  
  func getItem() {
    var keepAlive = true
    
    Alamofire.request("https://chalie-vice-api.herokuapp.com/chalie_vice/letters/" + (jsonData?["id"].stringValue)! + ".json")
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
  
  @IBAction func showDetail() {
    performSegue(withIdentifier: "showMagazineDetailPopup", sender: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showMagazineDetailPopup" {
      if let controller = segue.destination.popoverPresentationController {
        controller.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        controller.sourceView = self.view
        controller.sourceRect = CGRect(x: UIScreen.main.bounds.width * 0.5 - 400, y: UIScreen.main.bounds.height * 0.5 - 150, width: 800, height: 300)
        (segue.destination as! MagazineDetailPopupViewController).jsonDetailData = jsonDetailData
        segue.destination.preferredContentSize = CGSize(width: 800, height: 300)
        controller.delegate = self
        darkBackground.alpha = 0.5
      }
    }
  }

  func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
    darkBackground.alpha = 0.0
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
