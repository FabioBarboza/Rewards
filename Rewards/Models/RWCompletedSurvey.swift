//
//  RWCompletedSurvey.swift
//  Rewards
//
//  Created by Fabio Barboza on 28/10/16.
//  Copyright © 2016 PUCRS. All rights reserved.
//

import UIKit
import Parse

class RWCompletedSurvey: PFObject {
    
    @NSManaged var usedReward: Bool
    @NSManaged var person: RWPerson?
    @NSManaged var survey: RWSurvey?
    
    public static func parseClassName() -> String {
        return "CompletedSurvey"
    }
    
}
