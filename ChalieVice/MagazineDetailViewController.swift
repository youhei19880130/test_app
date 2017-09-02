//
//  MagazineDetailViewController.swift
//  ChalieVice
//
//  Created by nakazumi_hiroyuki on 2017/09/01.
//  Copyright © 2017年 LiveArts. All rights reserved.
//

import Foundation
import UIKit

class MagazineDetailViewController: UIViewController {
  
  public var ttt: String = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func showDetail() {
    performSegue(withIdentifier: "showMagazineDetailPopup", sender: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showMagazineDetailPopup" {
      if let controller = segue.destination.popoverPresentationController {
        controller.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        controller.sourceView = self.view
        controller.sourceRect = CGRect(x: UIScreen.main.bounds.width * 0.5 - 400, y: UIScreen.main.bounds.height * 0.5 - 200, width: 800, height: 300)
        segue.destination.preferredContentSize=CGSize(width: 800, height: 300)
      }
    }
  }

}
