//
//  MemeTableViewController.swift
//  Meme1.0
//
//  Created by Anas Belkhadir on 10/10/2015.
//  Copyright © 2015 Anas Belkhadir. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (
            title: "plus",
            style: UIBarButtonItemStyle.Plain,
            target: self,
            action: "GOTO")
    }
    
    func GOTO(){
//        let MemeVC = MemeViewController()
//        presentViewController(MemeVC, animated: true, completion: nil)
    }
    
    var memes: [Meme]! {
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
 
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "MemeImage"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.imageView?.image = memes[indexPath.row].memedImage
        cell.textLabel?.text = memes[indexPath.row].topText
        return cell
        
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let detailVC = self.storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        detailVC.meme = self.memes[indexPath.row]
        self.navigationController!.pushViewController(detailVC, animated: true)        
    }
    
    
}
