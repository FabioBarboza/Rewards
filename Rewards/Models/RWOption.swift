//
//  RWOption.swift
//  Rewards
//
//  Created by Fabio Barboza on 28/10/16.
//  Copyright © 2016 PUCRS. All rights reserved.
//

import UIKit
import Parse

class RWOption: PFObject, PFSubclassing {

    @NSManaged var question: RWQuestion?
    @NSManaged var label: String?
    @NSManaged var order: NSNumber?
    
    public static func parseClassName() -> String {
        return "Option"
    }
    
}
