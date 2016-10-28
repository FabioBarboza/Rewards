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
    
    @IBOutlet weak var txtEmail: UITextField! {
        didSet {
            txtEmail.delegate = self
            txtEmail.layer.borderColor = UIColor.init(red: 98.0/255.0, green: 112.0/255.0, blue: 241.0/255.0, alpha: 0.2).cgColor;
            txtEmail.layer.borderWidth = 2;
            txtEmail.layer.cornerRadius = 22;
        }
    }
    @IBOutlet weak var txtPassword: UITextField! {
        didSet {
            txtPassword.delegate = self
            txtPassword.layer.borderColor = UIColor.init(red: 98.0/255.0, green: 112.0/255.0, blue: 241.0/255.0, alpha: 0.2).cgColor;
            txtPassword.layer.borderWidth = 2;
            txtPassword.layer.cornerRadius = 22;
        }
    }
    @IBOutlet weak var btnLogin: UIButton! {
        didSet {
            btnLogin.clipsToBounds = true;
            btnLogin.layer.cornerRadius = 22;
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doLogin(_ sender: UIButton) {
        
        let user = PFObject(className:"User")
        user["name"] = "Minha pesquisa"
        user["reward"] = "Descontos"
        user["showReward"] = true
        user.saveInBackground { (success, error) in
            if success == true {
                print("funcionou")
            }
            else {
                print("erro")
            }
        }

        self.performSegue(withIdentifier: "SurveysSegue", sender: sender);
    }

    /*
     MARK: - Navigation

     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         Get the new view controller using segue.destinationViewController.
         Pass the selected object to the new view controller.
    }
    */

}
