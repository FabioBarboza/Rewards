//
//  SurveyCompletionVC.swift
//  Rewards
//
//  Created by Fabio Barboza on 29/11/16.
//  Copyright © 2016 PUCRS. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit

class SurveyCompletionVC: UIViewController {

    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var complete: UIButton!
    var survey: RWSurvey?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        complete.isEnabled = false
        
        guard let survey = survey else {
            return
        }
        
        RWCompletedSurvey.store(survey: survey) { success in
            
            self.activityIndicator.stopAnimating()
            self.complete.isEnabled = true
            self.codeLabel.text = success
        }
        
        let content = FBSDKShareLinkContent()
        content.contentURL = NSURL(string: "http://www.kobe.io") as URL!
        content.contentTitle = "Rewards - Pesquisas inteligentes"
        content.contentDescription = "Responda pesquisas rápidas e ganhe promoções exclusivas nas suas lojas e restaurantes favoritos."
        let shareButton = FBSDKShareButton()
        shareButton.shareContent = content;
        shareButton.center = view.center;
        view.addSubview(shareButton)
    }
    
    @IBAction func completeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
