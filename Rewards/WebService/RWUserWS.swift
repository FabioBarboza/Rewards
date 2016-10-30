//
//  RWUserWS.swift
//  Rewards
//
//  Created by Fabio Barboza on 29/10/16.
//  Copyright © 2016 PUCRS. All rights reserved.
//

import UIKit
import Parse

typealias SUCCESS = (_ result: Bool) -> ()
typealias FAILURE = (_ error: NSError) -> ()

class RWUserWS: NSObject {
    
    static func login(username: String, password: String, success: @escaping SUCCESS, failure: @escaping FAILURE) {
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil {
                success(true)
            }
            else {
                failure(error as! NSError)
            }
        }
    }
    
}
