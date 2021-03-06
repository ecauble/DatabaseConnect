//
//  ResetPasswordViewController.swift
//  DatabaseConnect
//
//  Created by Eric Cauble on 1/23/16.
//  Copyright © 2016 Eric Cauble. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD


class ResetPasswordViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet var emailAddressTextField: UITextField!
    
    // MARK:- View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let defUser = defaults.stringForKey("user_name"){
            emailAddressTextField.text = defUser
        }
        let swipeGestureRecognizer : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipeGestureReconizer:")
        swipeGestureRecognizer.direction = .Right
        self.view.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:- Actions
    @IBAction func resetButtonPressed(sender: AnyObject) {
        SVProgressHUD.showSuccessWithStatus("An email with instructions on reseting your password has been sent.")
        //self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //MARK:- SwipeGestureReconizer
    func handleSwipeGestureReconizer(gestureReconizer: UISwipeGestureRecognizer) {
        self.dismissViewControllerAnimated(true, completion: nil)
        print("swiped from right")
    }
    
}