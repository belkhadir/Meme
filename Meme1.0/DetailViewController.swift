//
//  File.swift
//  Meme1.0
//
//  Created by Anas Belkhadir on 10/10/2015.
//  Copyright © 2015 Anas Belkhadir. All rights reserved.
//

import Foundation

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!

    var meme: Meme!
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true
        self.image?.image = meme.memedImage
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
}