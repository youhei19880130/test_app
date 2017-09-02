//
//  MagazineDetailPopupViewController.swift
//  ChalieVice
//
//  Created by nakazumi_hiroyuki on 2017/09/01.
//  Copyright © 2017年 LiveArts. All rights reserved.
//

import UIKit
import QRCode

class MagazineDetailPopupViewController: UIViewController {

  @IBOutlet var qrCodeView: UIImageView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // String
    var qrCode = QRCode("http://schuch.me")
    qrCode?.size = CGSize(width: 202, height: 202)
    qrCodeView?.image = qrCode?.image
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}
