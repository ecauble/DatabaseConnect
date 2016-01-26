//
//  SignInViewController.swift
//  DatabaseConnect
//
//  Created by Eric Cauble on 1/23/16.
//  Copyright © 2016 Eric Cauble. All rights reserved.
//

import UIKit


class SignInViewController: UIViewController {
    
    
    //MARK:- Outlets
    @IBOutlet var emailAddressTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    //MARK:- Variables
    var userName: String?
    var passWord: String?
    
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
    
    }
}