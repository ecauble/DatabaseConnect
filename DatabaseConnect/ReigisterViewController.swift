//
//  ViewController.swift
//  DatabaseConnect
//
//  Created by Eric Cauble on 1/17/16.
//  Copyright © 2016 Eric Cauble. All rights reserved.
//

import UIKit

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
        let myUrl = NSURL(string: "http://localhost:8888/api/registerUser.php")
        let request = NSMutableURLRequest(URL:myUrl!)
        request.HTTPMethod = "POST"
        
        let postString = "user_name=\(userName.text!)&password=\(password.text!)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data:NSData?, response: NSURLResponse?, error:NSError?) -> Void in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                if error != nil
                {
                    // display an alert message
                    print(error!.localizedDescription)
                    return
                }
                do {

                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                    
                    if let parseJSON = json {
                        if let objects  = parseJSON["userID"] as? [AnyObject]
                        {
                            for obj in objects
                            {
                                let temp = (obj["userID"] as! String)
                                print(temp)
                                // self.searchResults.append(fullName)
                            }
                            
                        } else if(parseJSON["message"] != nil)
                        {
                            let errorMessage = parseJSON["message"] as? String
                            if(errorMessage != nil)
                            {
                                // display an alert message
                                
                            }
                        }
                    }
                    
                } catch {
                    print(error)
                }
            }
        })
        task.resume()

    }

}

