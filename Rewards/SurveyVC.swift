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
        
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "SurveyCell")! as UITableViewCell
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + 4
    }
}
