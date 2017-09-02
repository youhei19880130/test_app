//
//  ItemViewController.swift
//  ChalieVice
//
//  Created by 染谷洋平 on 2017/08/25.
//  Copyright © 2017 LiveArts. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ItemViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
  
  var jsonData: JSON?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getItems()
  }
  
  func getItems() {
    var keepAlive = true
    
    Alamofire.request("https://chalie-vice-api.herokuapp.com/chalie_vice/items.json")
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
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
    
    let index = indexPath.row
    let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)

    let typeLabel: UILabel = cell.contentView.viewWithTag(1) as! UILabel
    let imageView: UIImageView = cell.contentView.viewWithTag(2) as! UIImageView
    let descLabel: UILabel = cell.contentView.viewWithTag(3) as! UILabel
    

    imageView.image = try! UIImage(data: Data(contentsOf: URL(string: "http://img.chalievice.com/system/magazine_images/images/000/000/004/245/MM_image.jpg?1488280230")!))
    
    typeLabel.text = "ITEM"
    let description = jsonData?[index]["description"].stringValue
    descLabel.text = description?.substring(to: (description?.index((description?.startIndex)!, offsetBy: 20))!)
    
    return cell
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return (jsonData?.count)!;
  }
  
  private var selectedIndex: Int?
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let index = indexPath.row
    if index >= 0 {
      selectedIndex = index
      performSegue(withIdentifier: "showItemFromList", sender: nil)
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showItemFromList" {
      if let dest = segue.destination as? ItemDetailViewController {
        dest.jsonData = jsonData?[selectedIndex!]
      }
    }
  }
  
  @IBAction func unwindToItems(segue: UIStoryboardSegue) {
  }

}

