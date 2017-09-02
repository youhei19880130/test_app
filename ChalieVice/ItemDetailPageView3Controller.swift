//
//  ItemDetailPageView3Controller.swift
//  ChalieVice
//
//  Created by nakazumi_hiroyuki on 2017/09/02.
//  Copyright © 2017年 LiveArts. All rights reserved.
//

import UIKit

class ItemDetailPageView3Controller: UIViewController {

  public var parentVC: ItemDetailPageViewController?
  @IBOutlet var videoPlayer: UIWebView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    videoPlayer.scrollView.isScrollEnabled = false;
    videoPlayer.scrollView.bounces = false;
    videoPlayer.loadRequest(URLRequest(url: URL(string: "https://www.youtube.com/embed/mmIMMWYZfo4")!))
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func prev() {
    parentVC?.previousPage()
  }
  
  @IBAction func next() {
    parentVC?.nextPage()
  }

}
