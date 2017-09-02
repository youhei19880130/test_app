//
//  AboutViewController.swift
//  ChalieVice
//
//  Created by 染谷洋平 on 2017/08/26.
//  Copyright © 2017 LiveArts. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
  @IBOutlet weak var webView: UIWebView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    webView.scrollView.isScrollEnabled = false;
    webView.scrollView.bounces = false;
    webView.loadRequest(URLRequest(url: URL(string: "https://www.youtube.com/embed/NdzCaLOREnY")!))
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}
