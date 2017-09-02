//
//  ItemDetailPageViewController.swift
//  ChalieVice
//
//  Created by nakazumi_hiroyuki on 2017/09/02.
//  Copyright © 2017年 LiveArts. All rights reserved.
//

import UIKit

class ItemDetailPageViewController: UIPageViewController {
  
  private var vcs: [UIViewController]?
  private var vcsIndex = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setViewControllers([getFirstViewController()], direction: .forward, animated: true, completion: nil)
  }
  
  
  func getFirstViewController() -> UIViewController {
    if vcs == nil {
      vcs = []
      
      let vc1: ItemDetailPageView1Controller
      vc1 = storyboard!.instantiateViewController(withIdentifier: "DetailPageView1") as! ItemDetailPageView1Controller
      vc1.parentVC = self
      vcs?.append(vc1)
      
      let vc2: ItemDetailPageView2Controller
      vc2 = storyboard!.instantiateViewController(withIdentifier: "DetailPageView2") as! ItemDetailPageView2Controller
      vc2.parentVC = self
      vcs?.append(vc2)
      
      let vc3: ItemDetailPageView3Controller
      vc3 = storyboard!.instantiateViewController(withIdentifier: "DetailPageView3") as! ItemDetailPageView3Controller
      vc3.parentVC = self
      vcs?.append(vc3)
      
      let vc4: ItemDetailPageView4Controller
      vc4 = storyboard!.instantiateViewController(withIdentifier: "DetailPageView4") as! ItemDetailPageView4Controller
      vc4.parentVC = self
      vcs?.append(vc4)
    }
    return vcs![0]
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
