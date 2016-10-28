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
    
    var usedReward: Bool?
    var person: RWPerson?
    var survey: RWSurvey?

}
