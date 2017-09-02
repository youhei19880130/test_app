//
//  ItemDetailPageView4Controller.swift
//  ChalieVice
//
//  Created by nakazumi_hiroyuki on 2017/09/02.
//  Copyright © 2017年 LiveArts. All rights reserved.
//

import UIKit

class ItemDetailPageView4Controller: UIViewController {
  
  public var parentVC: ItemDetailPageViewController?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func prev() {
    parentVC?.previousPage()
  }

}
