//
//  ViewController.swift
//  ChalieVice
//
//  Created by 染谷洋平 on 2017/08/25.
//  Copyright © 2017 LiveArts. All rights reserved.
//

import UIKit

extension UIColor {
  class func hexStr ( hexStr : NSString, alpha : CGFloat) -> UIColor {
    let alpha = alpha
    var hexStr = hexStr
    hexStr = hexStr.replacingOccurrences(of: "#", with: "") as NSString
    let scanner = Scanner(string: hexStr as String)
    var color: UInt32 = 0
    if scanner.scanHexInt32(&color) {
      let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
      let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
      let b = CGFloat(color & 0x0000FF) / 255.0
      return UIColor(red:r,green:g,blue:b,alpha:alpha)
    } else {
      print("invalid hex string")
      return UIColor.white;
    }
  }
}

class ViewController: UIViewController, UITabBarDelegate {
  
  @IBOutlet weak var testView1: UIView!
  @IBOutlet weak var testView2: UIView!
  @IBOutlet weak var testView3: UIView!
  @IBOutlet weak var testView4: UIView!
  @IBOutlet weak var testView5: UIView!
  @IBOutlet weak var testTabBar: UITabBar!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let appearance = UITabBarItem.appearance()
    let attributes = [NSFontAttributeName:UIFont(name: "Hiragino Mincho ProN", size: 20)]
    appearance.setTitleTextAttributes(attributes, for: .normal)
    
    //TOP画面のみ表示にする。
    testView1.isHidden = false
    testView2.isHidden = true
    testView3.isHidden = true
    testView4.isHidden = true
    testView5.isHidden = true
    
    //デリゲート先を自分に設定する。
    testTabBar.delegate = self
    
    //デザイン
    testTabBar.tintColor = UIColor.hexStr(hexStr: "000000", alpha: 1)
    testTabBar.unselectedItemTintColor = UIColor.hexStr(hexStr: "afafaf", alpha: 1)
    /*        testTabBar.items![2].image = UIImage(named: "logo.png")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
     testTabBar.items![2].selectedImage = UIImage(named: "logo.png")*/
    testTabBar.selectedItem = testTabBar.items?[0]
    
    let bottomBorder = CALayer()
    bottomBorder.frame = CGRect(x: 0, y: testTabBar.frame.height, width: testTabBar.frame.width, height: 0.5)
    bottomBorder.backgroundColor = UIColor.hexStr(hexStr: "afafaf", alpha: 1).cgColor
    testTabBar.layer.addSublayer(bottomBorder)
  }
  
  //ボタン押下時の呼び出しメソッド
  func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem){
    print(item.tag)
    switch item.tag {
    case 1:
      //TOP画面を表示する。
      testView1.isHidden = false
      testView2.isHidden = true
      testView3.isHidden = true
      testView4.isHidden = true
      testView5.isHidden = true
    case 2:
      //ABOUT画面を表示する。
      testView1.isHidden = true
      testView2.isHidden = false
      testView3.isHidden = true
      testView4.isHidden = true
      testView5.isHidden = true
    case 3:
      //MAGAZINE画面を表示する。
      testView1.isHidden = true
      testView2.isHidden = true
      testView3.isHidden = false
      testView4.isHidden = true
      testView5.isHidden = true
    case 4:
      //ITEM画面を表示する。
      testView1.isHidden = true
      testView2.isHidden = true
      testView3.isHidden = true
      testView4.isHidden = false
      testView5.isHidden = true
    case 5:
      //EVENT画面を表示する。
      testView1.isHidden = true
      testView2.isHidden = true
      testView3.isHidden = true
      testView4.isHidden = true
      testView5.isHidden = false
    default:
      return
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

