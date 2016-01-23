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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let defUserFName = defaults.stringForKey("first_name"){
           welcomeLabel.text = "Welcome " + defUserFName + " !"
        }
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
