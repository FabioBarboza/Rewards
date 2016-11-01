//
//  LoginVC.swift
//  Rewards
//
//  Created by Fabio Barboza on 10/12/16.
//  Copyright © 2016 PUCRS. All rights reserved.
//

import UIKit
import Parse

class LoginVC: UIViewController, UITextFieldDelegate {
    
    let borderWidth = 2.0
    let borderAlpha = 0.2
    let warningTitle = "Atenção"
    let emailFieldValidation = "O email precisa ter ao menos 5 letras."
    let passwordFieldValidation = "A senha precisa ter ao menos 5 letras."
    let surveySegue = "SurveysSegue"
    
    @IBOutlet weak var txtEmail: UITextField! {
        didSet {
            txtEmail.delegate = self
            txtEmail.layer.borderColor = UIColor.purpleTintColor(alpha: CGFloat(borderAlpha)).cgColor
            txtEmail.layer.borderWidth = CGFloat(borderWidth)
            txtEmail.layer.cornerRadius = 22.0
//            txtEmail.layer.cornerRadius = txtEmail.layer.frame.size.height/2.0
        }
    }
    @IBOutlet weak var txtPassword: UITextField! {
        didSet {
            txtPassword.delegate = self
            txtPassword.layer.borderColor = UIColor.purpleTintColor(alpha: CGFloat(borderAlpha)).cgColor
            txtPassword.layer.borderWidth = CGFloat(borderWidth)
            txtPassword.layer.cornerRadius = 22.0
//            txtPassword.layer.cornerRadius = txtPassword.layer.frame.size.height/2.0
        }
    }
    @IBOutlet weak var btnLogin: UIButton! {
        didSet {
            btnLogin.clipsToBounds = true
            btnLogin.layer.cornerRadius = 22.0
//            btnLogin.layer.cornerRadius = btnLogin.layer.frame.size.height/2.0
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - ViewController Delegates
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - Actions
    
    @IBAction func doLogin(_ sender: UIButton) {
        
        guard let email = txtEmail, txtEmail.charactersInRange(5)
            else {
                let  alertController = UIAlertController.basicMessage(warningTitle, message: emailFieldValidation)
                present(alertController, animated: true, completion: nil)
                return
        }
        guard let password = txtPassword, txtPassword.charactersInRange(5)
            else {
                let  alertController = UIAlertController.basicMessage(warningTitle, message: passwordFieldValidation)
                present(alertController, animated: true, completion: nil)
                return
        }
        
        loading(true)
        
        RWUserWS.login(username: email.text!, password: password.text!, success: { (success) in
            self.loading(false)
            self.performSegue(withIdentifier: self.surveySegue, sender: sender)
            }) { (error) in
                self.loading(false)
        }

//        let user = PFObject(className:"User")
//        user["email"] = txtEmail
//        user["showReward"] = true
//        user.saveInBackground { (success, error) in
//            if success == true {
//                print("funcionou")
//            }
//            else {
//                print("erro")
//            }
//        }

    }
    
    func loading(_ enable: Bool) {
        btnLogin.isUserInteractionEnabled = !enable
        txtPassword.isUserInteractionEnabled = !enable
        txtEmail.isUserInteractionEnabled = !enable
        
        if enable == true {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }

    //MARK: - Textfield Delegates
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
