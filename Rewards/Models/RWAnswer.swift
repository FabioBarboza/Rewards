
//
//  RWAnswer.swift
//  Rewards
//
//  Created by Fabio Barboza on 28/10/16.
//  Copyright © 2016 PUCRS. All rights reserved.
//

import UIKit
import Parse

class RWAnswer: PFObject, PFSubclassing {

    @NSManaged var survey: RWSurvey?
    @NSManaged var options: RWOption?
    @NSManaged var person: RWPerson?
    @NSManaged var question: RWQuestion?
    
    public static func parseClassName() -> String {
        return "Answer"
    }
    
    public static func store(with survey: RWSurvey,
              options: RWOption,
              person: RWPerson,
              question: RWQuestion) {
        
        let answer = PFObject(className:RWAnswer.parseClassName())
        answer["survey"] = survey
        answer["options"] = options
        answer["person"] = person
        answer["question"] = question
        
        answer.saveInBackground()
    }
    
}
