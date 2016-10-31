//
//  RWUserWS.swift
//  Rewards
//
//  Created by Fabio Barboza on 29/10/16.
//  Copyright © 2016 PUCRS. All rights reserved.
//

import UIKit
import Parse

typealias LOGIN_SUCCESS = (_ result: Bool) -> ()
typealias LOGIN_FAILURE = (_ error: NSError) -> ()

class RWUserWS: NSObject {
    
    static func login(username: String, password: String, success: @escaping LOGIN_SUCCESS, failure: @escaping LOGIN_FAILURE) {
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
