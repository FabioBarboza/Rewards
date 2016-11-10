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
    let dataLoaderSegue = "dataLoaderSegue"
    
    var survey: RWSurvey?
    var questionList = NSMutableArray()
    var optionList = NSMutableArray()
    var currentQuestion = 0
    var loaded = false
    
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

        loadOptions(to: currentQuestion)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if loaded == true {
            loadOptions(to: currentQuestion)
        }
    }
    
    func loadOptions(to question: Int) {
        if questionList.count == 0 {
            loadObjects()
        } else {
            if let question = questionList[currentQuestion] as? RWQuestion {
                loading(true)
                RWSurveysWS.options(with: question.objectId!, success: { (list) in
                    
                    self.optionList.removeAllObjects()
                    self.optionList = list
                    self.tableView.reloadData()
                    self.loading(false)

                }, failure: { (error) in
                    self.loading(false)
                })
            } else {
                
            }
        }
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
        
        self.performSegue(withIdentifier: dataLoaderSegue, sender: nil)
    }
    
    //MARK: - Tableview
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0) {
            let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: questionCellID)! as UITableViewCell
            
            let question = questionList[currentQuestion] as! RWQuestion
            let title = cell.viewWithTag(1) as! UILabel
            title.text = question.label
            
            return cell;
        }
        else {
            let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: optionCellID)! as UITableViewCell
            
            let option = optionList[indexPath.row - 1] as! RWOption
            let title = cell.viewWithTag(1) as! UILabel
            title.text = option.label
            
            return cell;
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if optionList.count == 0 {
            return 0
        } else {
            return optionList.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Actions
    
    @IBAction func nextQuestionAction(_ sender: AnyObject) {
        navigationController!.popViewController(animated: true);
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == dataLoaderSegue {
            if let destinationVC = segue.destination as? DataLoaderVC {
                destinationVC.surveyVC = self
            }
        }
    }
}
