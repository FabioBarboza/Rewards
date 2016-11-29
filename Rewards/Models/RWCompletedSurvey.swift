//
//  RWCompletedSurvey.swift
//  Rewards
//
//  Created by Fabio Barboza on 28/10/16.
//  Copyright © 2016 PUCRS. All rights reserved.
//

import UIKit
import Parse

class RWCompletedSurvey: PFObject, PFSubclassing {
    
    @NSManaged var usedReward: Bool
    @NSManaged var person: RWPerson?
    @NSManaged var survey: RWSurvey?
    
    public static func parseClassName() -> String {
        return "CompletedSurvey"
    }
    
    public static func store(survey: RWSurvey,
                             completion: @escaping (String) -> ()) {
        let completedSurvey = PFObject(className: parseClassName())
        
        let query = PFQuery(className: RWPerson.parseClassName())
        query.whereKey("user", equalTo: PFUser.current() as Any)
        query.limit = 1
        query.findObjectsInBackground { (object, error) in
            if object != nil {
                completedSurvey["person"] = object?.first
                completedSurvey["survey"] = survey
                completedSurvey["usedReward"] = false
                
                completedSurvey.saveInBackground { (success, error) in
                    if error == nil {
                        completion(completedSurvey.objectId!)
                    } else {
                        completion("Erro 404")
                    }
                }
            }
        }
    }
}
