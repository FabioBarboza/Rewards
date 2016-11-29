//
//  ProfileVC.swift
//  Rewards
//
//  Created by Fabio Barboza on 10/12/16.
//  Copyright © 2016 PUCRS. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var surveyList = [RWCompletedSurvey]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Perfil"
        profilePicture.layer.borderColor = UIColor.clear.cgColor;
        profilePicture.layer.borderWidth = 1;
        profilePicture.layer.cornerRadius = 50;
        
        loadData()
    }
    
    func loadData() {
        activityIndicator.startAnimating()
        RWSurveysWS.completedSurveys(success: { list in
            self.activityIndicator.stopAnimating()
            self.surveyList = list
            self.tableView.reloadData()
        }, failure: { error in
            self.activityIndicator.stopAnimating()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surveyList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CompletedSurveyCell = self.tableView.dequeueReusableCell(withIdentifier: "SurveyCell") as! CompletedSurveyCell
        let completedSurvey = surveyList[indexPath.row]
        
        cell.surveyTitle.text = completedSurvey.survey?.title
        cell.surveyLocation.text = completedSurvey.survey?.company?.companyName
        cell.surveyReward.text = completedSurvey.survey?.reward
        
        if completedSurvey.usedReward == true {
            cell.selectionStyle = .none
            cell.surveyImage.alpha = 0.5
        } else {
            cell.selectionStyle = .default
            cell.surveyImage.alpha = 1.0
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let completedSurvey = surveyList[indexPath.row]
        
        if completedSurvey.usedReward == false {
            let alertController = UIAlertController.basicMessage(completedSurvey.objectId!,
                                                                 message: "Apresente o código no caixa da loja e retire seu prêmio")
            present(alertController, animated: true, completion: nil)
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

}
