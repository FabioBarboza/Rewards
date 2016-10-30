//
//  Extension.swift
//  Rewards
//
//  Created by Fabio Barboza on 29/10/16.
//  Copyright © 2016 PUCRS. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    class func purpleTintColor(alpha: CGFloat) -> UIColor {
        return UIColor(red: 98.0/255.0, green: 112.0/255.0, blue: 241.0/255.0, alpha: alpha)
    }
    
}

extension UITextField {
    
    func charactersInRange(_ range: Int) -> Bool {
        return (self.text?.characters.count)! >= range
    }
    
    func containsCharacter(_ character: String) -> Bool {
        return (self.text?.contains(character))!
    }
    
}

extension UIAlertController {
    
    class func basicMessage(_ title:String, message:String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let OkAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OkAction)
        return alertController
    }
    
}
