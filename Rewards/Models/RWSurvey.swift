//
//  RWSurvey.swift
//  Rewards
//
//  Created by Fabio Barboza on 27/10/16.
//  Copyright © 2016 PUCRS. All rights reserved.
//

import UIKit
import Parse

class RWSurvey: PFObject {
    
    var title: String?
    var questions: Array<RWQuestion>?
    var endDate: Date?
    var reward: String?
    var showReward: Bool?
    
}
