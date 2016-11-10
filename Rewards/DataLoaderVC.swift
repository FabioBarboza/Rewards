//
//  DataLoaderVC.swift
//  Rewards
//
//  Created by Fabio Barboza on 09/11/16.
//  Copyright © 2016 PUCRS. All rights reserved.
//

import UIKit

class DataLoaderVC: UIViewController {

    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    weak var surveyVC: SurveyVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    func loadData() {
        self.btnStart.isEnabled = false
        self.activityIndicator.startAnimating()
        
        RWSurveysWS.questions(with: (surveyVC.survey?.objectId)!, success: { (list) in
            self.surveyVC.questionList = NSMutableArray(array: list)
            
            self.btnStart.isEnabled = true
            self.activityIndicator.stopAnimating()
        }) { (error) in
            let alertController = UIAlertController.basicMessage(self.surveyVC.warningTitle,
                                                                 message: self.surveyVC.questionQueryError)
            self.present(alertController,
                         animated: true,
                         completion: nil)
            
            self.btnStart.isEnabled = true
            self.activityIndicator.stopAnimating()
        }
    }
    
    @IBAction func startSurvey(_ sender: Any) {
        self.surveyVC.loaded = true
        self.dismiss(animated: true, completion: nil)
    }

}
