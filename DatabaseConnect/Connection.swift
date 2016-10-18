//
//  Connection.swift
//  DatabaseConnect
//
//  Created by Eric Cauble on 2/11/16.
//  Copyright © 2016 Eric Cauble. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Connection {
    
    static let sharedInstance = Connection()
    
    init() {
        print("connection instantiated")
    }
    
    func registerNewUser(userName : String, password : String) {
        if(userName != "" && password != ""){
            Alamofire.request(.POST, kLocalHost + "/api/registerUser.php", parameters: ["user_name": (userName), "password" : password])
                .responseJSON {
                    response in
                    switch response.result {
                        //inserted user, write user id to defaults
                    case .Success(let data):
                        let json = JSON(data)
                        let userID = json["user"]["user_id"].int!
                        defaults.setObject(userID, forKey: "user_id")
                        defaults.setObject(userName, forKey: "user_name")
                        //TODO: store password in coredata for safety
                        defaults.setObject(password, forKey: "password")
                        
                    case .Failure(let error):
                        print("Request failed with error: \(error)")
                    }
            }
        }else{
            print("Please include username and password")
        }
    }
    
    
    //loads video files from request
    func loadMedia(tableView : UITableView) -> [String] {
        var searchResults = [String]()
        Alamofire.request(.POST, kLocalHost + "/api/findMedia.php", parameters: nil).responseJSON {
            response in
            switch response.result {
            case .Success(let data):
                let json = JSON(data)
                for file in json["files"]{
                    searchResults.append(file.1.string!)
                }
            case .Failure(let error):
                print("Request failed with error: \(error)")
            }
        }
         return searchResults
    }//end func load media
    
}