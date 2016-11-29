//
//  SurveyCompletionVC.swift
//  Rewards
//
//  Created by Fabio Barboza on 29/11/16.
//  Copyright © 2016 PUCRS. All rights reserved.
//

import UIKit

class SurveyCompletionVC: UIViewController {

    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var complete: UIButton!
    
    @IBAction func completeAction(_ sender: Any) {
    }
}
