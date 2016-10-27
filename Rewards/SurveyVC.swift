//
//  SurveyVC.swift
//  Rewards
//
//  Created by Fabio Barboza on 13/10/16.
//  Copyright © 2016 PUCRS. All rights reserved.
//

import UIKit

class SurveyVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0) {
            let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "QuestionCell")! as UITableViewCell
            return cell;
        }
        else {
            let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "OptionCell")! as UITableViewCell
            return cell;
        }
        
    }
    
    @IBAction func nextQuestionAction(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true);
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 70
        }
        return 60
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + 4
    }
}
