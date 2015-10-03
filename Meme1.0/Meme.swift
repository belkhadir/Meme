//
//  Meme.swift
//  Meme1.0
//
//  Created by Anas Belkhadir on 03/10/2015.
//  Copyright © 2015 Anas Belkhadir. All rights reserved.
//

import Foundation
import UIKit
class Meme {
    
    let topText:String
    let bottomText:String
    let image: UIImage
    let memedImage: UIImage
    
    init (topText: String, bottomText: String, image: UIImage, memedImage: UIImage){
        self.topText = topText
        self.bottomText = bottomText
        self.image = image
        self.memedImage = memedImage
    }



    
}