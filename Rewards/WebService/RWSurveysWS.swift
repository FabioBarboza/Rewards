//
//  RWSurveysWS.swift
//  Rewards
//
//  Created by Fabio Barboza on 30/10/16.
//  Copyright © 2016 PUCRS. All rights reserved.
//

import UIKit
import Parse

typealias SURVEY_SUCCESS = (_ result: NSMutableArray) -> ()
typealias SURVEY_FAILURE = (_ error: NSError) -> ()

class RWSurveysWS: NSObject {
    
    static func surveys(success: @escaping SURVEY_SUCCESS, failure: @escaping SURVEY_FAILURE) {
        
        let query = PFQuery(className:"Survey")
        query.includeKey("company")
        query.findObjectsInBackground { (list, error) in
            if error == nil {
                
                let surveys = NSMutableArray()
                for object in list! {
                    let survey = object as! RWSurvey
                    surveys.add(survey)
                }
                success(surveys)
            } else {
                
            }
        }
    }

}
