//
//  ViewController.swift
//  Meme1.0
//
//  Created by Anas Belkhadir on 02/10/2015.
//  Copyright © 2015 Anas Belkhadir. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate , UITextFieldDelegate {

    @IBOutlet weak var topToolBar: UINavigationBar!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.whiteColor(),
        NSForegroundColorAttributeName : UIColor.blackColor(),
        NSFontAttributeName : UIFont(name: "Didot", size: 40)!,
        NSStrokeWidthAttributeName : 5.0
    ]

    
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    let commentTextField = ComentTextFieldDelegate()
    
    @IBOutlet weak var imageViewPicker: UIImageView!
    @IBOutlet weak var camreBar: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       camreBar.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.delegate = commentTextField
        
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.delegate = commentTextField
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.subscribeToKeyboardNotification()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeToKeyboardNotification()
 
    }

    
    @IBAction func shareButtonTapped(sender: UIBarButtonItem) {
        if topTextField.text == "TOP" || bottomTextField.text == "BOTTOM" {
            let message = UIAlertController()
            message.title = "error occur"
            message.message = "Please edit the image"
            let alert = UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: {action in self.dismissViewControllerAnimated(true, completion: nil)})
            message.addAction(alert)
            presentViewController(message, animated: true, completion: nil)
        }
        else{
            let sharedVC = UIActivityViewController(activityItems: [topTextField.text!], applicationActivities: nil)
            self.presentViewController(sharedVC, animated: true, completion: nil)
            
        }
    }
    
    
    @IBAction func pickAnImageFromAlbum(sender: UIBarButtonItem) {
    
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageViewPicker.image = image
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func subscribeToKeyboardNotification(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }

    
    func unsubscribeToKeyboardNotification(){
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
         NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }

    func keyboardWillHide(notification: NSNotification){
        self.view.frame.origin.y = 0 
    }

    
    
    @IBAction func pickAnImageFromCamera(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }

    func save(){
        let meme = Meme(topText: topTextField.text!  , bottomText: bottomTextField.text! , image: imageViewPicker.image!, memedImage: generateMemedImage())
    }
    
    func generateMemedImage() -> UIImage {
        
        
        topToolBar.hidden = true
        bottomToolBar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        topToolBar.hidden = false
        topToolBar.hidden = false
        return memedImage
    }
    
}











