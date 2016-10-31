//
//  RWPerson.swift
//  Rewards
//
//  Created by Fabio Barboza on 27/10/16.
//  Copyright © 2016 PUCRS. All rights reserved.
//

import UIKit
import Parse

class RWPerson: PFObject, PFSubclassing {
    
    @NSManaged var completedSurveys: Array<RWCompletedSurvey>?
    @NSManaged var user: PFUser?
    
    public static func parseClassName() -> String {
        return "Person"
    }
    
}
