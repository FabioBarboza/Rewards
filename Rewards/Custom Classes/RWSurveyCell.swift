//
//  RWSurveyCell.swift
//  Rewards
//
//  Created by Fabio Barboza on 30/10/16.
//  Copyright © 2016 PUCRS. All rights reserved.
//

import UIKit

class RWSurveyCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var surveyImage: UIImageView!
    @IBOutlet weak var surveyTitle: UILabel!
    @IBOutlet weak var surveyDeadline: UILabel!
    @IBOutlet weak var surveyReward: UILabel!
    @IBOutlet weak var surveyLocation: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
