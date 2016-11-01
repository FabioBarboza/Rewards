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
                failure(error as! NSError)
             }
        }
    }
    
    static func questions(with surveyID: String, success: @escaping SURVEY_SUCCESS, failure: @escaping SURVEY_FAILURE) {
        
        let innerQuery = PFQuery(className:"Survey")
        innerQuery.whereKey("objectId", equalTo: surveyID)
        let query = PFQuery(className:"Question")
        query.whereKey("survey", matchesQuery: innerQuery)
        query.findObjectsInBackground { (list, error) in
            if error == nil {
                let questions = NSMutableArray()
                for object in list! {
                    let question = object as! RWQuestion
                    questions.add(question)
                }
                success(questions)
            } else {
                failure(error as! NSError)
            }
        }
    }

}
