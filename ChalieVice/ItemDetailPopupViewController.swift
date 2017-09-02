//
//  ItemDetailPopupViewController.swift
//  ChalieVice
//
//  Created by nakazumi_hiroyuki on 2017/09/02.
//  Copyright © 2017年 LiveArts. All rights reserved.
//

import UIKit
import QRCode

class ItemDetailPopupViewController: UIViewController {
  
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
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */

}
