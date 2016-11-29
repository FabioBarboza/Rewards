//
//  SurveysVC.swift
//  Rewards
//
//  Created by Fabio Barboza on 10/12/16.
//  Copyright © 2016 PUCRS. All rights reserved.
//

import UIKit
import Parse

class SurveysVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let navTitle = "Pesquisas"
    let surveyCellID = "SurveyCell"
    let surveySegue = "SurveySegue"
    let profileSegue = "ProfileSegue"
    let warningTitle = "Reload the list"
    let surveyQueryError = "Occured an error trying to get the surveys"
    
    var surveyList = NSMutableArray()
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tableFooterView = UIView(frame: CGRect.zero)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = navTitle
        
        loadObjects()
    }
    
    //MARK: - Data
    
    func loadObjects() {
        loading(true)
        RWSurveysWS.surveys(success: { (list) in
            self.surveyList = NSMutableArray(array: list)
            self.tableView.reloadData()
            self.loading(false)
        }) { (error) in
            let alertController = UIAlertController.basicMessage(self.warningTitle, message: self.surveyQueryError)
            self.present(alertController, animated: true, completion: nil)
            self.loading(false)
        }
        
    }
    
    func loading(_ enable: Bool) {
        if enable == true {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    //MARK: - Tableview
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surveyList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:RWSurveyCell = tableView.dequeueReusableCell(withIdentifier: surveyCellID)! as! RWSurveyCell
        let survey = surveyList[indexPath.row] as! RWSurvey
        
        cell.surveyTitle.text = survey.title
        cell.surveyLocation.text = survey.company?.companyName
        cell.surveyReward.text = survey.reward
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: surveySegue, sender: indexPath)
    }
    
    //MARK: - Navigation
    
    @IBAction func showProfile(_ sender: AnyObject) {
        self.performSegue(withIdentifier: profileSegue, sender: sender);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == surveySegue {
            let navController = segue.destination as! UINavigationController
            let surveyVC = navController.viewControllers.first as! DataLoaderVC
            let indexPath = sender as! IndexPath
            surveyVC.survey = surveyList[indexPath.row] as? RWSurvey
        }
    }

}
