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
    var optionList = NSMutableArray()
    var currentQuestion = 0
    
    var answers = [RWAnswer]()
    var selectedOption: RWOption?
    var lastIndexPath: IndexPath?
    
    @IBOutlet weak var nextButton: UIButton!
    
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
    
    func loadOptions(to questionNumber: Int) {
        guard let survey = self.survey,
            let questions = survey.questions else {
                return
        }
        
        if questionNumber + 1 >= questions.count {
            nextButton.setTitle("ENVIAR", for: .normal)
        } else {
            nextButton.setTitle("PRÓXIMA PERGUNTA", for: .normal)
        }
        
        if questions.count > questionNumber {
            let question = questions[questionNumber]
            loading(true)
            RWSurveysWS.options(with: question.objectId!, success: { (list) in
                
                self.optionList.removeAllObjects()
                self.optionList = list
                self.tableView.reloadData()
                self.loading(false)
                self.selectedOption = nil
                
            }, failure: { (error) in
                self.loading(false)
            })
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
            guard let survey = self.survey,
                let questions = survey.questions else {
                    return UITableViewCell()
            }
            let question = questions[currentQuestion]
            let title = cell.viewWithTag(1) as! UILabel
            title.text = question.label
            
            return cell;
        }
        else {
            let cell: OptionCell = tableView.dequeueReusableCell(withIdentifier: optionCellID) as! OptionCell
            
            let option = optionList[indexPath.row - 1] as! RWOption
            cell.optionTitle.text = option.label
            
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
        
        if lastIndexPath != nil {
            tableView.deselectRow(at: lastIndexPath!, animated: true)
        }
        
        if indexPath.row > 0 {
            selectedOption = optionList[indexPath.row - 1] as? RWOption
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            lastIndexPath = indexPath
        }
    }
    
    //MARK: - Actions
    
    @IBAction func closeSurvey(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextQuestionAction(_ sender: AnyObject) {
        if selectedOption == nil { return }
        
        guard let survey = survey,
            let questions = survey.questions,
            let option = selectedOption else {
                return
        }

        RWAnswer.store(with: survey,
                       options: option,
                       question: questions[currentQuestion])
        
        currentQuestion+=1
        if currentQuestion == questions.count {
            performSegue(withIdentifier: "SurveyCompletion", sender: nil)
        } else {
            loadOptions(to: currentQuestion)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SurveyCompletion" {
            let surveyVC = segue.destination as! SurveyCompletionVC
            surveyVC.survey = survey
        }
    }
}
