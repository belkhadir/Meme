//
//  ViewController.swift
//  Meme1.0
//
//  Created by Anas Belkhadir on 02/10/2015.
//  Copyright © 2015 Anas Belkhadir. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate , UITextFieldDelegate {

    @IBOutlet weak var topToolBar: UINavigationBar!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.whiteColor(),
        NSForegroundColorAttributeName : UIColor.blackColor(),
        NSFontAttributeName : UIFont(name: "Didot", size: 40)!,
        NSStrokeWidthAttributeName : 5.0
    ]

    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
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
        subscribeToKeyboardNotification()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotification()
 
    }

    
    @IBAction func shareButtonTapped(sender: UIBarButtonItem) {
        if topTextField.text == "TOP" || bottomTextField.text == "BOTTOM" || imageViewPicker.image == nil {
            let message = UIAlertController()
            message.title = "error occur"
            message.message = "Please edit the image"
            let alert = UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: {action in self.dismissViewControllerAnimated(true, completion: nil)})
            message.addAction(alert)
            presentViewController(message, animated: true, completion: nil)
        }
        else{
            
            let saveImage = generateMemedImage()
            let sharedVC = UIActivityViewController(activityItems: [saveImage], applicationActivities: nil)
            sharedVC.completionWithItemsHandler = {
                (s: String?, ok: Bool, items: [AnyObject]?, err:NSError?) -> Void in self.save()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            
            presentViewController(sharedVC, animated: true, completion: nil)
            
            
        }
    }
    
    
    @IBAction func pickAnImageFromAlbum(sender: UIBarButtonItem) {
    
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageViewPicker.image = image
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        view.frame.origin.y -= getKeyboardHeight(notification)
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
        view.frame.origin.y = 0 
    }

    
    
    @IBAction func pickAnImageFromCamera(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    func save() {
        let meme = Meme(topText: topTextField!.text!  , bottomText: bottomTextField!.text! , image: imageViewPicker!.image!, memedImage: generateMemedImage())
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage {
        
        
        topToolBar.hidden = true
        bottomToolBar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        topToolBar.hidden = false
        topToolBar.hidden = false
        return memedImage
    }
    
}











