//
//  ItemViewController.swift
//  ChalieVice
//
//  Created by 染谷洋平 on 2017/08/25.
//  Copyright © 2017 LiveArts. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
    
    let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)

    // Cell view parts
    let typeLabel: UILabel = cell.contentView.viewWithTag(1) as! UILabel
    let imageView: UIImageView = cell.contentView.viewWithTag(2) as! UIImageView
    let descLabel: UILabel = cell.contentView.viewWithTag(3) as! UILabel
    
    imageView.image = try! UIImage(data: Data(contentsOf: URL(string: "http://img.chalievice.com/system/magazine_images/images/000/000/004/245/MM_image.jpg?1488280230")!))
    
    typeLabel.text = "aaaaaa"
    descLabel.text = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"

    return cell
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10;
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let index = indexPath.row
    if index > 0 {
      performSegue(withIdentifier: "showItemFromList", sender: nil)
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showItemFromList" {
      if let dest = segue.destination as? MagazineDetailViewController {
        dest.ttt = "test"
      }
    }
  }
  
  @IBAction func unwindToMagazines(segue: UIStoryboardSegue) {
  }

}

