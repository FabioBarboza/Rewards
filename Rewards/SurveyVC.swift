//
//  SurveyVC.swift
//  Rewards
//
//  Created by Fabio Barboza on 13/10/16.
//  Copyright © 2016 PUCRS. All rights reserved.
//

import UIKit

class SurveyVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let navTitle = "Pesquisa"
    let questionCellID = "QuestionCell"
    let optionCellID = "OptionCell"
    let warningTitle = "Reload the list"
    let questionQueryError = "Occured an error trying to get the questions"
    
    var survey: RWSurvey?
    var questionList = NSMutableArray()
    
    @IBOutlet weak var surveyDeadline: UILabel! {
        didSet {
            surveyDeadline.text = "Termina em 1 dia"
        }
    }
    
    @IBOutlet weak var surveyReward: UILabel! {
        didSet {
            surveyReward.text = survey?.reward
        }
    }
    
    @IBOutlet weak var surveyLocation: UILabel! {
        didSet {
            surveyLocation.text = survey?.company?.companyName
        }
    }
    
    @IBOutlet weak var surveyTitle: UILabel! {
        didSet {
            surveyTitle.text = survey?.title
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 60
        }
    }
    
    //MARK: - ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = navTitle
        
        loadObjects()
    }
    
    //MARK: - Data
    
    func loading(_ enable: Bool) {
        if enable == true {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func loadObjects() {
        loading(true)
        RWSurveysWS.questions(with: (survey?.objectId)!, success: { (list) in
            self.questionList = NSMutableArray(array: list)
            self.tableView.reloadData()
            self.loading(false)
        }) { (error) in
            let alertController = UIAlertController.basicMessage(self.warningTitle, message: self.questionQueryError)
            self.present(alertController, animated: true, completion: nil)
            self.loading(false)
        }
        
    }
    
    //MARK: - Tableview
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0) {
            let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: questionCellID)! as UITableViewCell
            
            let question = questionList[indexPath.row] as! RWQuestion
            let title = cell.viewWithTag(1) as! UILabel
            title.text = question.label
            
            return cell;
        }
        else {
            let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: optionCellID)! as UITableViewCell
            return cell;
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if questionList.count == 0 {
            return 0
        } else {
            count += 1
        }
        return count + 4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Actions
    
    @IBAction func nextQuestionAction(_ sender: AnyObject) {
        navigationController!.popViewController(animated: true);
    }
}
