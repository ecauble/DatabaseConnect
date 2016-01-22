//
//  MediaBrowserViewController.swift
//  DatabaseConnect
//
//  Created by Eric Cauble on 1/21/16.
//  Copyright © 2016 Eric Cauble. All rights reserved.
//

import UIKit
import SVProgressHUD

class MediaBrowserViewController: UIViewController {
    
    //instance variables
    
    //constants
    var searchResults = [String]()
    
    //outlets
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func doSearch(searchWord: String){
        
        //http://10.0.1.26:8888
        let myUrl = NSURL(string: "http://10.0.1.26:8888/ghstest/findAllFriends.php")
        
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "POST";
        
        let postString = "searchWord=\(searchWord)&userId=23";
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data:NSData?, response: NSURLResponse?, error:NSError?) -> Void in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                if error != nil
                {
                    // display an alert message
                    SVProgressHUD.showErrorWithStatus(error!.localizedDescription)
                    return
                }
                
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                    
                    
                    if let parseJSON = json {
                        
                        if let friends  = parseJSON["friends"] as? [AnyObject]
                        {
                            
                            for friendObj in friends
                            {
                                let fullName = (friendObj["first_name"] as! String) + " " + (friendObj["last_name"] as! String)
                                
                                self.searchResults.append(fullName)
                            }
                            self.tableView.reloadData()
                            
                        } else if(parseJSON["message"] != nil)
                        {
                            
                            let errorMessage = parseJSON["message"] as? String
                            if(errorMessage != nil)
                            {
                                // display an alert message
                                SVProgressHUD.showErrorWithStatus(errorMessage!)
                                
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

extension MediaBrowserViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        cell.textLabel?.text = self.searchResults[indexPath.row] as String
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        SVProgressHUD.showInfoWithStatus("didSelectRowAtIndexPath: \(indexPath.row)")
    }
    
}