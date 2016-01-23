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
                .responseJSON {
                    response in
                switch response.result {
                //inserted user, write user id to defaults
                case .Success(let data):
                    let json = JSON(data)
                    let userID = json["user"]["user_id"].int!
                    defaults.setObject(userID, forKey: "user_id")
                    defaults.setObject(self.userName.text!, forKey: "user_name")
                    //TODO: store password in coredata for safety
                    defaults.setObject(self.password.text!, forKey: "password")

                 case .Failure(let error):
                    print("Request failed with error: \(error)")
                }
            }
        }else{
            SVProgressHUD.showErrorWithStatus("Please include username and password")
        }
    }

}

