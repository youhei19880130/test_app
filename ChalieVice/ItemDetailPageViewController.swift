//
//  ItemDetailPageViewController.swift
//  ChalieVice
//
//  Created by nakazumi_hiroyuki on 2017/09/02.
//  Copyright © 2017年 LiveArts. All rights reserved.
//

import UIKit
import SwiftyJSON

class ItemDetailPageViewController: UIPageViewController {
  
  public var jsonDetailData: JSON?
  
  private var vcs: [UIViewController]?
  private var vcsIndex = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()

    var vcIndex: Int = 0
    vcs = []
    
    let imageUrlList: [JSON] = jsonDetailData!["image_url"].array!
    for imageUrl: JSON in imageUrlList {
      let vc: ItemDetailImagePageViewController = storyboard!.instantiateViewController(withIdentifier: "ItemDetailImagePageViewController") as! ItemDetailImagePageViewController
      vc.parentVC = self
      vc.jsonDetailData = jsonDetailData
      vc.imageUrl = imageUrl.stringValue
      /*
      switch vcIndex {
      case 0:
        vc.prevButton?.isHidden = true
        vc.nextButton?.isHidden = false
      default:
        vc.prevButton?.isHidden = false
        vc.nextButton?.isHidden = false
      }
      */
      if vcIndex == 0 {
        vc.prevButton?.removeFromSuperview()
      }
      vcs?.append(vc)
      vcIndex += 1
    }
    
    let youtubeUrl: String = jsonDetailData!["youtube_url"].stringValue
    if youtubeUrl == "" {
      // (vcs?[(vcs?.count)! - 1] as! ItemDetailImagePageViewController).nextButton?.isHidden = true
      (vcs?[(vcs?.count)! - 1] as! ItemDetailImagePageViewController).nextButton?.removeFromSuperview()
    } else {
      let vc: ItemDetailYoutubePageViewController = storyboard!.instantiateViewController(withIdentifier: "ItemDetailYoutubePageViewController") as! ItemDetailYoutubePageViewController
      vc.parentVC = self
      vc.jsonDetailData = jsonDetailData
      vc.youtubeUrl = youtubeUrl
      vcs?.append(vc)
      vcIndex += 1
    }
    
    self.setViewControllers([(vcs?[0])!], direction: .forward, animated: true, completion: nil)
  }

  public func nextPage(){
    
    let target = (vcs!.count - 1 > vcsIndex) ? vcsIndex + 1 : vcsIndex
    
    let currentViewController = vcs?[vcsIndex]
    let nextViewController = vcs?[target]
    
    setViewControllers([nextViewController!], direction: .forward, animated: true, completion: nil)
    
    vcsIndex = target
  }

  public func previousPage(){
    
    let target = (0 < vcsIndex) ? vcsIndex - 1 : vcsIndex
    
    let currentViewController = vcs?[vcsIndex]
    let previousViewController = vcs?[target]
    
    setViewControllers([previousViewController!], direction: .reverse, animated: true, completion: nil)
   
    vcsIndex = target
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
