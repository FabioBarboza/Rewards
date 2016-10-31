//
//  RWQuestion.swift
//  Rewards
//
//  Created by Fabio Barboza on 28/10/16.
//  Copyright © 2016 PUCRS. All rights reserved.
//

import UIKit
import Parse

class RWQuestion: PFObject, PFSubclassing {
    
    @NSManaged var survey: RWSurvey?
    @NSManaged var label: String?
    @NSManaged var options: Array<RWOption>?
    
    public static func parseClassName() -> String {
        return "Question"
    }
    
}
