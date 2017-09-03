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
    let priceLabel: UILabel = cell.contentView.viewWithTag(4) as! UILabel
    
    let imgUrlString: String? = jsonData?[index]["image_url"].stringValue
    if let url = imgUrlString {
      if url != "" {
        imageView.image = try! UIImage(data: Data(contentsOf: URL(string: url)!))
      }
    }
    
    let price: String = (jsonData?[index]["price"].stringValue)!
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
    
    typeLabel.text = jsonData?[index]["category_name"].stringValue
    let description = jsonData?[index]["name"].stringValue
    let endIndex = (description?.characters.count)! > 20 ? 20 : description?.characters.count
    descLabel.text = description?.substring(to: (description?.index((description?.startIndex)!, offsetBy: endIndex!))!)
    
    return cell
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return (jsonData?.count)!
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

