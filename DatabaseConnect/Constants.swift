//
//  Constants.swift
//  DatabaseConnect
//
//  Created by Eric Cauble on 1/17/16.
//  Copyright © 2016 Eric Cauble. All rights reserved.
//

import Foundation

class Constants{

    //set bool to localhost's ip only for testing, ignore warning
    static func getLocalHostIP() -> String
    {
        let isLocal = true

        if(isLocal){
            return "http://localhost:8888/"
        }else
        {
            //set to local machine's ip
            return "http://10.0.1.26:8888/"
        }
    }

}//ends class constants

let kLocalHost = Constants.getLocalHostIP()