//
//  Constants.swift
//  DatabaseConnect
//
//  Created by Eric Cauble on 1/17/16.
//  Copyright © 2016 Eric Cauble. All rights reserved.
//

import Foundation

class Constants{
    
    static func getLocalHostIP(isLocal : Bool) -> String{

        if(isLocal){
            return "http://localhost:8888/"
        }else
        {
            /** testing on a remote server **/
            return "https://ecauble.com"
        }
    }

}//ends class constants


//global constants for convenience
let kLocalHost = Constants.getLocalHostIP(false)
let defaults = NSUserDefaults.standardUserDefaults()

