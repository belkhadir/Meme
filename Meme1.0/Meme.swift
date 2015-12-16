//
//  Meme.swift
//  Meme1.0
//
//  Created by Anas Belkhadir on 03/10/2015.
//  Copyright © 2015 Anas Belkhadir. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class Meme :NSManagedObject{
    
    struct dictionaryKey {
        static let topTextForKey = "top_text"
        static let bottomTextForKey = "bottom_text"
        static let pathForKey = "path"
    }
    
    
    @NSManaged var topText:String
    @NSManaged var bottomText:String
    @NSManaged var path:String?
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    init(dictionary: [String: AnyObject], context: NSManagedObjectContext){
        let entity = NSEntityDescription.entityForName("Meme", inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        topText = dictionary[dictionaryKey.topTextForKey] as! String
        bottomText = dictionary[dictionaryKey.bottomTextForKey] as! String
        path = dictionary[dictionaryKey.pathForKey] as? String
    }
    
    
    var image: UIImage? {
        set {
            ImageCache.sharedInstance().storeImage(image, withIdentifier: path!)
        }
        get{
            return ImageCache.sharedInstance().imageWithIdentifier(path!)
        }
    }
    
    var memedImage: UIImage? {
        set {
            ImageCache.sharedInstance().storeImage(image, withIdentifier: path!)
        }
        get{
            return ImageCache.sharedInstance().imageWithIdentifier(path!)
        }
    }
}



