//
//  ItemDetailViewController.swift
//  ChalieVice
//
//  Created by nakazumi_hiroyuki on 2017/09/02.
//  Copyright © 2017年 LiveArts. All rights reserved.
//

import UIKit
import SwiftyJSON

class ItemDetailViewController: UIViewController {

  public var jsonData: JSON?
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    nameLabel.text = jsonData!["name"].stringValue
    priceLabel.text = jsonData!["price"].stringValue
    
    let vc: ItemDetailPageViewController = storyboard!.instantiateViewController(withIdentifier: "ItemDetailPageViewController") as! ItemDetailPageViewController
    vc.jsonData = jsonData
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
      }
    }
  }
}
