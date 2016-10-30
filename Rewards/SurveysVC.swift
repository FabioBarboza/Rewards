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
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = navTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: surveyCellID)! as UITableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: surveySegue, sender: indexPath)
    }
    
    @IBAction func showProfile(_ sender: AnyObject) {
        self.performSegue(withIdentifier: profileSegue, sender: sender);
    }

}
