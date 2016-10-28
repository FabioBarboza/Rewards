//
//  RWUser.swift
//  Rewards
//
//  Created by Fabio Barboza on 27/10/16.
//  Copyright © 2016 PUCRS. All rights reserved.
//

import UIKit
import Parse

class RWUser: NSObject {
    
    var user : PFUser?
    var profilePicture : PFFile?
    var name : String?
    var email : String?
    var username : String?
    var company : RWCompany?
    var person : RWPerson?

}
