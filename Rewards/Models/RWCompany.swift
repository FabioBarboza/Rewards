//
//  RWCompany.swift
//  Rewards
//
//  Created by Fabio Barboza on 27/10/16.
//  Copyright © 2016 PUCRS. All rights reserved.
//

import UIKit
import Parse

class RWCompany: PFObject {

    var address : String?
    var geoPoint : PFGeoPoint?
    var cnpj : String?
//    var surveys : Array<RWSurvey>?
    var user : PFUser?
    
}
