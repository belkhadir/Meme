//
//  ComentTextFieldDelegate.swift
//  Meme1.0
//
//  Created by Anas Belkhadir on 02/10/2015.
//  Copyright © 2015 Anas Belkhadir. All rights reserved.
//

import Foundation
import UIKit

class ComentTextFieldDelegate: NSObject, UITextFieldDelegate {
 
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}