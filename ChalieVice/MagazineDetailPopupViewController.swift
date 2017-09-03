//
//  MagazineDetailPopupViewController.swift
//  ChalieVice
//
//  Created by nakazumi_hiroyuki on 2017/09/01.
//  Copyright © 2017年 LiveArts. All rights reserved.
//

import UIKit
import QRCode
import SwiftyJSON

class MagazineDetailPopupViewController: UIViewController {

  @IBOutlet var qrCodeView: UIImageView?
  public var jsonDetailData: JSON?
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var itemImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // String
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
  
}
