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

typealias QUESTION_SUCCESS = (_ result: [RWQuestion]) -> ()
typealias QUESTION_FAILURE = (_ error: NSError) -> ()

typealias COMPLETED_SURVEYS_SUCCESS = (_ result: [RWCompletedSurvey]) -> ()
typealias COMPLETED_SURVEYS_FAILURE = (_ error: NSError) -> ()


class RWSurveysWS: NSObject {
    
    static func surveys(success: @escaping SURVEY_SUCCESS,
                        failure: @escaping SURVEY_FAILURE) {
        
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
    
    static func questions(with surveyID: String,
                          success: @escaping QUESTION_SUCCESS,
                          failure: @escaping QUESTION_FAILURE) {
        
        let innerQuery = PFQuery(className:"Survey")
        innerQuery.whereKey("objectId", equalTo: surveyID)
        let query = PFQuery(className:"Question")
        query.whereKey("survey", matchesQuery: innerQuery)
        query.findObjectsInBackground { (list, error) in
            if error == nil {
                var questions = [RWQuestion]()
                for object in list! {
                    let question = object as! RWQuestion
                    questions.append(question)
                }
                success(questions)
            } else {
                failure(error as! NSError)
            }
        }
    }
    
    static func options(with questionID: String,
                        success: @escaping SURVEY_SUCCESS,
                        failure: @escaping SURVEY_FAILURE) {
        
        let innerQuery = PFQuery(className: "Question")
        innerQuery.whereKey("objectId", equalTo: questionID)
        let query = PFQuery(className: "Option")
        query.whereKey("question", matchesQuery: innerQuery)
        query.findObjectsInBackground { (list, error) in
            if error == nil {
                let options = NSMutableArray()
                for object in list! {
                    let option = object as! RWOption
                    options.add(option)
                }
                success(options)
            } else {
                failure(error as! NSError)
            }
        }
    }
    
    static func completedSurveys(success: @escaping COMPLETED_SURVEYS_SUCCESS,
                                 failure: @escaping COMPLETED_SURVEYS_FAILURE) {
        
        let innerQuery = PFQuery(className: "Person")
        innerQuery.whereKey("user", equalTo: PFUser.current() as Any)
        let query = PFQuery(className: "CompletedSurvey")
        query.whereKey("person", matchesQuery: innerQuery)
        query.includeKey("survey")
        query.includeKey("survey.company")
        query.order(by: NSSortDescriptor(key: "usedReward", ascending: true))
        
        query.findObjectsInBackground { (list, error) in
            if error == nil {
                var completedSurveys = [RWCompletedSurvey]()
                for object in list! {
                    let question = object as! RWCompletedSurvey
                    completedSurveys.append(question)
                }
                success(completedSurveys)
            } else {
                failure(error as! NSError)
            }
        }
    }
}
