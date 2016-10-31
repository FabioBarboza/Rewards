//
//  RWCompany.swift
//  Rewards
//
//  Created by Fabio Barboza on 27/10/16.
//  Copyright © 2016 PUCRS. All rights reserved.
//

import UIKit
import Parse

class RWCompany: PFObject, PFSubclassing {

    @NSManaged var address: String?
    @NSManaged var geoPoint: PFGeoPoint?
    @NSManaged var cnpj: String?
    @NSManaged var surveys: Array<RWSurvey>?
    @NSManaged var user: PFUser?
    @NSManaged var companyName: String?
    
    public static func parseClassName() -> String {
        return "Company"
    }
    
}
