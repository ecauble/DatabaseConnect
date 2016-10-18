//
//  ViewController.swift
//  DatabaseConnect
//
//  Created by Eric Cauble on 1/17/16.
//  Copyright © 2016 Eric Cauble. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class RegisterViewController: UIViewController, UITextFieldDelegate{
    
    //outlets
    @IBOutlet var userName: UITextField!
    @IBOutlet var password: UITextField!

    // MARK:- View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if (identifier == "showRegisterDetails" ) && (userName.text == "" || password.text == ""){
            return false
        }else{
            return true
        }
    }
 

    
    //inserts new user in database
    @IBAction func registerNewUser(sender: AnyObject) {
        
        Connection.sharedInstance.registerNewUser(userName.text!, password: password.text!)
    }

}//ends class

