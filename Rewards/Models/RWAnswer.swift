
//
//  RWAnswer.swift
//  Rewards
//
//  Created by Fabio Barboza on 28/10/16.
//  Copyright © 2016 PUCRS. All rights reserved.
//

import UIKit
import Parse

class RWAnswer: PFObject {

    var survey: RWSurvey?
    var options: Array<RWOption>?
    var person: RWPerson?
    var question: RWQuestion?
    
}
