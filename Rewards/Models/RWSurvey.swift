//
//  RWSurvey.swift
//  Rewards
//
//  Created by Fabio Barboza on 27/10/16.
//  Copyright © 2016 PUCRS. All rights reserved.
//

import UIKit
import Parse

class RWSurvey: PFObject, PFSubclassing {
    
    @NSManaged var title: String?
    @NSManaged var questions: Array<RWQuestion>?
    @NSManaged var endDate: Date?
    @NSManaged var reward: String?
    @NSManaged var showReward: Bool
    @NSManaged var company: RWCompany?
    
    public static func parseClassName() -> String {
        return "Survey"
    }

}
