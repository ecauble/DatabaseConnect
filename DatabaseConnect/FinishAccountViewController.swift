//
//  FinalizeAccountViewController.swift
//  DatabaseConnect
//
//  Created by Eric Cauble on 1/23/16.
//  Copyright © 2016 Eric Cauble. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD


class FinishAccountViewController: UIViewController, UITextFieldDelegate{
   
    //MARK: - Outlets
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    
    
    //MARK:- Variables
    var userID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        userID = defaults.integerForKey("user_id")
        let swipeGestureRecognizer : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipeGestureReconizer:")
        swipeGestureRecognizer.direction = .Right
        self.view.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Actions
    @IBAction func doneButtonPressed(sender: AnyObject) {
        
        if(firstNameTextField.text != "" && lastNameTextField.text != ""){
            Alamofire.request(.POST, kLocalHost + "/api/submitUserInfo.php", parameters: ["first_name": (firstNameTextField.text!), "last_name" : lastNameTextField.text!, "user_id" : userID!])
                .responseJSON {
                    response in
                    switch response.result {
                        //inserted user, write user id to defaults
                    case .Success( _):
                        if let value = response.result.value {
                            let json = JSON(value)
                            print("JSON: \(json)")
                        }
                        defaults.setObject(self.firstNameTextField.text!, forKey: "first_name")
                        defaults.setObject(self.lastNameTextField.text!, forKey: "last_name")
                        
                    case .Failure(let error):
                        print("Request failed with error: \(error)")
                    }
            }
        }else{
            SVProgressHUD.showErrorWithStatus("Please include first name and last name")
        }
    }
    
    
    //MARK:- SwipeGestureReconizer
    func handleSwipeGestureReconizer(gestureReconizer: UISwipeGestureRecognizer) {
        self.dismissViewControllerAnimated(true, completion: nil)
        print("swiped from right")
    }
    
}