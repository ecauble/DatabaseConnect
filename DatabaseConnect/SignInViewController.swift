//
//  SignInViewController.swift
//  DatabaseConnect
//
//  Created by Eric Cauble on 1/23/16.
//  Copyright © 2016 Eric Cauble. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class SignInViewController: UIViewController {
    
    
    //MARK:- Outlets
    @IBOutlet var emailAddressTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    //MARK:- Variables
   

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
    
    
    //MARK:- SwipeGestureReconizer
    func handleSwipeGestureReconizer(gestureReconizer: UISwipeGestureRecognizer) {
        self.dismissViewControllerAnimated(true, completion: nil)
        print("swiped from right")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Actions
    @IBAction func signInButtonPressed(sender: AnyObject) {
        if(emailAddressTextField.text != "" && passwordTextField.text != ""){
            Alamofire.request(.POST, kLocalHost + "/api/logIn.php", parameters: ["user_name": (emailAddressTextField.text!), "password" : passwordTextField.text!])
                .responseJSON {
                    response in
                    switch response.result {
                        //read json to get user_id, store in defaults
                    case .Success:
                        if let value = response.result.value {
                            let json = JSON(value)
                            print("JSON: \(json)")
                        }
                    case .Failure(let error):
                        print("Request failed with error: \(error)")
                    }
            }
        }else{
            SVProgressHUD.showErrorWithStatus("Please include username and password")
        }

    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if (identifier == "showRootView" ) && (emailAddressTextField.text == "" || passwordTextField.text == ""){
            SVProgressHUD.showErrorWithStatus("Please include email address and password")
            return false
        }else{
            return true
        }
    }
    
}