//
//  MemeTableViewController.swift
//  Meme1.0
//
//  Created by Anas Belkhadir on 10/10/2015.
//  Copyright © 2015 Anas Belkhadir. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MemeTableViewController: UIViewController, UITableViewDataSource,
    UITableViewDelegate,NSFetchedResultsControllerDelegate {

    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem (
            barButtonSystemItem: .Add,
            target: self,
            action: "Edit")
        do {
            try fetchedResultsController.performFetch()
        }catch _ {}
        
        fetchedResultsController.delegate = self
        
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    lazy var sharedContext: NSManagedObjectContext = {
       CoreDataStackManager.sharedInstance().managedObjectContext
    }()

    lazy var fetchedResultsController: NSFetchedResultsController = {
       let fetchRequest = NSFetchRequest(entityName: "MemeCollection")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "topText", ascending: true)]
       let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.sharedContext, sectionNameKeyPath: nil, cacheName: nil)
    return fetchedResultsController
    }()
    
    func Edit(){
        let edit = self.storyboard!.instantiateViewControllerWithIdentifier("MemeViewController") as! MemeViewController
        presentViewController(edit, animated: true, completion: nil)
    
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
 
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        
        switch type {
            case .Insert :
                tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
            case .Delete :
                tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
            default :
                return
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
            case .Insert:
                tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
            case .Delete:
                tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            case .Move:
                tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
                tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
            default:
                return
        }
    }
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        
        tableView.endUpdates()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "MemeImage"
        let meme = fetchedResultsController.objectAtIndexPath(indexPath) as! Meme
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = meme.topText
        return cell
        
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let detailVC = self.storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        let meme = fetchedResultsController.objectAtIndexPath(indexPath) as! Meme
        detailVC.meme = meme
        self.navigationController!.pushViewController(detailVC, animated: true)        
    }
    
    
}
