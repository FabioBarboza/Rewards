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
    
    var surveyList = NSMutableArray()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = navTitle
        
        loadObjects()
    }
    
    func loadObjects() {
        
        RWSurveysWS.surveys(success: { (list) in
            self.surveyList = NSMutableArray(array: list)
            self.tableView.reloadData()
        }) { (error) in
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surveyList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:RWSurveyCell = self.tableView.dequeueReusableCell(withIdentifier: surveyCellID)! as! RWSurveyCell
        let survey = surveyList[indexPath.row] as! RWSurvey
        
        cell.surveyTitle.text = survey.title
        cell.surveyLocation.text = survey.company?.address
        cell.surveyReward.text = survey.reward
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: surveySegue, sender: indexPath)
    }
    
    @IBAction func showProfile(_ sender: AnyObject) {
        self.performSegue(withIdentifier: profileSegue, sender: sender);
    }

}
