//
//  DataLoaderVC.swift
//  Rewards
//
//  Created by Fabio Barboza on 09/11/16.
//  Copyright © 2016 PUCRS. All rights reserved.
//

import UIKit

class DataLoaderVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let loadingTitle = "Carregando dados da pesquisa"
    let loadedTitle = "A pesquisa esta pronta"
    var survey: RWSurvey?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnStart.isEnabled = false
        activityIndicator.startAnimating()
        titleLabel.text = loadingTitle
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData() {
        btnStart.isEnabled = false
        activityIndicator.startAnimating()
        
        RWSurveysWS.questions(with: (survey?.objectId)!, success: { (list) in
            
            self.survey?.questions = list
            self.btnStart.isEnabled = true
            self.activityIndicator.stopAnimating()
            self.titleLabel.text = self.loadedTitle
            
        }) { (error) in
            let alertController = UIAlertController.basicMessage("Error",
                                                                 message: "Occured an error trying to get the questions")
            self.present(alertController,
                         animated: true,
                         completion: nil)
            
            self.btnStart.isEnabled = true
            self.activityIndicator.stopAnimating()
        }
    }
    
    @IBAction func startSurvey(_ sender: Any) {
        performSegue(withIdentifier: "QuestionsSegue", sender: nil)
    }
    
    @IBAction func closeSurvey(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "QuestionsSegue" {
            let surveyVC = segue.destination as! SurveyVC
            surveyVC.survey = survey
        }
    }
}
