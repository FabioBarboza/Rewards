//
//  RWQuestion.swift
//  Rewards
//
//  Created by Fabio Barboza on 28/10/16.
//  Copyright © 2016 PUCRS. All rights reserved.
//

import UIKit
import Parse

class RWQuestion: PFObject {
    
    var survey: RWSurvey?
    var label: String?
    var options: Array<RWOption>?
    
}
