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

    var memes: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        memes = applicationDelegate.memes
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (
            barButtonSystemItem: .Add,
            target: self,
            action: "Edit")
    }
    
    func Edit(){
        let edit = self.storyboard!.instantiateViewControllerWithIdentifier("MemeViewController") as! MemeViewController
        presentViewController(edit, animated: true, completion: nil)
    
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
