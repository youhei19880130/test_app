//
//  EyeCactchViewController.swift
//  ChalieVice
//
//  Created by nakazumi_hiroyuki on 2017/09/03.
//  Copyright © 2017年 LiveArts. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class EyeCactchViewController: UIViewController {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var itemImageView: UIImageView!
  @IBOutlet weak var itemNameLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var divisionLabel: UILabel!
  @IBOutlet weak var developerName: UILabel!
  @IBOutlet weak var tapView: UIView!
  
  var jsonData: JSON?
  var jsonDetailData1: JSON?
  var jsonDetailData2: JSON?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getItems()
    getDetailItems(id1: (jsonData?[0]["id"].stringValue)!, id2: (jsonData?[1]["id"].stringValue)!)
    
    tapView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped)))
    
    // ラベル
    titleLabel.text = jsonDetailData1!["name"].stringValue
    divisionLabel.text = jsonDetailData1!["friend_title"].stringValue
    developerName.text = jsonDetailData1!["friend_name"].stringValue
    itemNameLabel.text = jsonDetailData2!["name"].stringValue
    
    // 画像
    var imgUrlString: String? = jsonDetailData1?["image_url"].stringValue
    if imgUrlString != "" {
      imageView.image = try! UIImage(data: Data(contentsOf: URL(string: imgUrlString!)!))
    }

    imgUrlString = jsonDetailData2?["image_url"].stringValue
    if imgUrlString != "" {
      itemImageView.image = try! UIImage(data: Data(contentsOf: URL(string: imgUrlString!)!))
    }
  }
  
  func getItems() {
    var keepAlive = true
    
    Alamofire.request("https://chalie-vice-api.herokuapp.com/chalie_vice/letters.json?category=FROM+FRIENDS")
      .responseJSON { response in
        guard let object = response.result.value else {
          return
        }
        self.jsonData = JSON(object)
        keepAlive = false
    }
    
    let runLoop = RunLoop.current
    while keepAlive &&
      runLoop.run(mode: RunLoopMode.defaultRunLoopMode, before: NSDate(timeIntervalSinceNow: 0.1) as Date) {
    }
  }
  
  func getDetailItems(id1: String, id2: String) {
    var keepAlive = true
    
    Alamofire.request("https://chalie-vice-api.herokuapp.com/chalie_vice/letters/" + id1 + ".json")
      .responseJSON { response in
        guard let object = response.result.value else {
          return
        }
        self.jsonDetailData1 = JSON(object)
        keepAlive = false
    }
    
    var runLoop = RunLoop.current
    while keepAlive &&
      runLoop.run(mode: RunLoopMode.defaultRunLoopMode, before: NSDate(timeIntervalSinceNow: 0.1) as Date) {
    }

    keepAlive = true
    
    Alamofire.request("https://chalie-vice-api.herokuapp.com/chalie_vice/letters/" + id2 + ".json")
      .responseJSON { response in
        guard let object = response.result.value else {
          return
        }
        self.jsonDetailData2 = JSON(object)
        keepAlive = false
    }
    
    runLoop = RunLoop.current
    while keepAlive &&
      runLoop.run(mode: RunLoopMode.defaultRunLoopMode, before: NSDate(timeIntervalSinceNow: 0.1) as Date) {
    }

  }

  func tapped(){
    performSegue(withIdentifier: "showMainMenu", sender: nil)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func unwindToEyeCatch(segue: UIStoryboardSegue) {}

}
