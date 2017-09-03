//
//  ItemDetailPopupViewController.swift
//  ChalieVice
//
//  Created by nakazumi_hiroyuki on 2017/09/02.
//  Copyright © 2017年 LiveArts. All rights reserved.
//

import UIKit
import QRCode
import SwiftyJSON

class ItemDetailPopupViewController: UIViewController {
  
  @IBOutlet var qrCodeView: UIImageView?
  public var jsonDetailData: JSON?
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var itemImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    var qrCode = QRCode((jsonDetailData?["url"].stringValue)!)
    qrCode?.size = CGSize(width: 202, height: 202)
    qrCodeView?.image = qrCode?.image
    
    nameLabel.text = jsonDetailData?["name"].stringValue
    priceLabel.text = jsonDetailData?["url"].stringValue
    
    let imgUrlString: String? = jsonDetailData?["image_url"].stringValue
    if let url = imgUrlString {
      if url != "" {
        itemImageView.image = try! UIImage(data: Data(contentsOf: URL(string: url)!))
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */

}
