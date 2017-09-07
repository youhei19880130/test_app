//
//  ItemDetailImagePageViewController.swift
//  ChalieVice
//
//  Created by nakazumi_hiroyuki on 2017/09/02.
//  Copyright © 2017年 LiveArts. All rights reserved.
//

import UIKit
import SwiftyJSON

class ItemDetailImagePageViewController: UIViewController {

  public var imageUrl: String?
  public var parentVC: ItemDetailPageViewController?
  public var jsonDetailData: JSON?
  @IBOutlet weak var imageView: UIImageView!
  
  public var prevIsHidden: Bool? = false
  public var nextIsHidden: Bool? = false
  
  @IBOutlet var prevButton: UIButton?
  @IBOutlet var nextButton: UIButton?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let url = imageUrl {
      if url != "" {
        imageView.image = try! UIImage(data: Data(contentsOf: URL(string: url)!))
      }
    }
    
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
