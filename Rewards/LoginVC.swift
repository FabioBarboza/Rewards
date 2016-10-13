//
//  LoginVC.swift
//  Rewards
//
//  Created by Fabio Barboza on 10/12/16.
//  Copyright © 2016 PUCRS. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtEmail.layer.borderColor = UIColor.init(red: 98.0/255.0, green: 112.0/255.0, blue: 241.0/255.0, alpha: 0.2).cgColor;
        txtEmail.layer.borderWidth = 2;
        txtEmail.layer.cornerRadius = 22;
        
        txtPassword.layer.borderColor = UIColor.init(red: 98.0/255.0, green: 112.0/255.0, blue: 241.0/255.0, alpha: 0.2).cgColor;
        txtPassword.layer.borderWidth = 2;
        txtPassword.layer.cornerRadius = 22;
        
        btnLogin.clipsToBounds = true;
        btnLogin.layer.cornerRadius = 22;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doLogin(_ sender: UIButton) {
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
