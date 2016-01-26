//
//  AccountViewController.swift
//  DatabaseConnect
//
//  Created by Eric Cauble on 1/23/16.
//  Copyright © 2016 Eric Cauble. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    //MARK:- Variables
    var imagePicker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        imageView.autoresizesSubviews = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Actions
    @IBAction func changePhotoButtonPressed(sender: AnyObject) {
        //self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}

//MARK:- Extensions

extension AccountViewController : UIImagePickerControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imageView.image = resizeImage(image, newWidth: 68)
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    func imageTapped(img: AnyObject)
    {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .SavedPhotosAlbum
        //photo selected dismiss pickerView
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
}



