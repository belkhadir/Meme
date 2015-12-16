//
//  MemeCollectionViewController.swift
//  Meme1.0
//
//  Created by Anas Belkhadir on 10/10/2015.
//  Copyright © 2015 Anas Belkhadir. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewController:UICollectionViewController {
   
//    var memes: [Meme]!
    override func viewDidLoad() {
        super.viewDidLoad()
//        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
//        memes = applicationDelegate.memes
//        self.collectionView?.reloadData()
    }
    

//    
//    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return memes.count
//    }
//    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cellIdentifier = "MemeCollectionViewCell"
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! MemeCollectionViewCell
//        cell.image?.image = memes[indexPath.row].memedImage
//        return cell
//        
//    }
//    
//    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
//        let detailVC = self.storyboard!.instantiateViewControllerWithIdentifier("CollectionViewCell") as! DetailViewController
//        detailVC.image?.image = memes[indexPath.row].memedImage
//        self.navigationController!.pushViewController(detailVC, animated: true)
//    }
    
}
