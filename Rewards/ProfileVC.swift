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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Perfil"
        profilePicture.layer.borderColor = UIColor.clear.cgColor;
        profilePicture.layer.borderWidth = 1;
        profilePicture.layer.cornerRadius = 50;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "SurveyCell")! as UITableViewCell
        
        return cell
    }

}
