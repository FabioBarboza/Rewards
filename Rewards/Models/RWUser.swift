//
//  RWUser.swift
//  Rewards
//
//  Created by Fabio Barboza on 27/10/16.
//  Copyright © 2016 PUCRS. All rights reserved.
//

import UIKit
import Parse

class RWUser: NSObject, PFSubclassing {
    
    @NSManaged var user: PFUser?
    @NSManaged var profilePicture: PFFile?
    @NSManaged var name: String?
    @NSManaged var email: String?
    @NSManaged var username: String?
    @NSManaged var company: RWCompany?
    @NSManaged var person: RWPerson?
    
    public static func parseClassName() -> String {
        return "User"
    }
    
}
