//
//  OptionCell.swift
//  Rewards
//
//  Created by Fabio Barboza on 29/11/16.
//  Copyright © 2016 PUCRS. All rights reserved.
//

import UIKit

class OptionCell: UITableViewCell {

    @IBOutlet weak var optionTitle: UILabel!
    @IBOutlet weak var markImageView: UIImageView!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected == true {
            markImageView.image = UIImage(named: "checkmarked")
        } else {
            markImageView.image = UIImage(named: "checkmark")
        }
    }
}
