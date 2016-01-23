//
//  RegisterDevice.swift
//  DatabaseConnect
//
//  Created by Eric Cauble on 1/17/16.
//  Copyright © 2016 Eric Cauble. All rights reserved.
//

import UIKit


class RegisterDevice {
  
    
    func registerDeviceID(userID : Int, deviceID : String) {
        let myUrl = NSURL(string: kLocalHost+"api/registerClient.php")
        
        let request = NSMutableURLRequest(URL:myUrl!)
        request.HTTPMethod = "POST"
        
        let postString = "registerString=\(deviceID)"
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
                        if let objects  = parseJSON["registerString"] as? [AnyObject]
                        {
                            for obj in objects
                            {
                                let temp = (obj["registerString"] as! String)
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
                    print(error);
                }
            }
        })
        task.resume()
        
    }
    
}

