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

class RegisterViewController: UIViewController {
    
    
    
    //outlets
    @IBOutlet var userName: UITextField!
    @IBOutlet var password: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //inserts new user in database
    @IBAction func registerNewUser(sender: AnyObject) {
        if(userName.text != "" && password.text != ""){
        Alamofire.request(.POST, kLocalHost + "/api/registerUser.php", parameters: ["user_name": (userName.text!), "password" : password.text!])
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
       
        }
            SVProgressHUD.showSuccessWithStatus("Welcome \n\(userName.text!)")
        }else{
            SVProgressHUD.showErrorWithStatus("Please include username and password")
        }
    }

}

