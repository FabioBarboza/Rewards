//
//  AppDelegate.swift
//  Rewards
//
//  Created by Fabio Barboza on 9/29/16.
//  Copyright © 2016 PUCRS. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let configuration = ParseClientConfiguration {
            $0.applicationId = "mRwNNZmtzhlK4iOR0r0cYkUJtMpwIMy3wkz6SUnf"
            $0.clientKey = "2fYgWb8Fib2kUhoigiEXTszqFxDNiBUM73dtbagw"
        }
        Parse.initialize(with: configuration)
        
        RWSurvey.registerSubclass()
        RWCompany.registerSubclass()
        RWQuestion.registerSubclass()
        RWAnswer.registerSubclass()
        RWCompletedSurvey.registerSubclass()
        RWPerson.registerSubclass()
        RWOption.registerSubclass()
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
}

