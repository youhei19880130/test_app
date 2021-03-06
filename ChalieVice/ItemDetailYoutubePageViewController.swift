//
//  ItemDetailYoutubePageView3Controller.swift
//  ChalieVice
//
//  Created by nakazumi_hiroyuki on 2017/09/02.
//  Copyright © 2017年 LiveArts. All rights reserved.
//

import UIKit
import SwiftyJSON

class ItemDetailYoutubePageViewController: UIViewController {

  public var parentVC: ItemDetailPageViewController?
  public var jsonDetailData: JSON?
  public var youtubeUrl: String?
  @IBOutlet var videoPlayer: UIWebView!

  public var prevIsHidden: Bool? = false
  public var nextIsHidden: Bool? = false
  
  @IBOutlet var prevButton: UIButton?
  @IBOutlet var nextButton: UIButton?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    videoPlayer.scrollView.isScrollEnabled = false;
    videoPlayer.scrollView.bounces = false;
    videoPlayer.loadRequest(URLRequest(url: URL(string: youtubeUrl!)!))

    if prevIsHidden! {
      prevButton?.isHidden = true
    }
    if nextIsHidden! {
      nextButton?.isHidden = true
    }
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
