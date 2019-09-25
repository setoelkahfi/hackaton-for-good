//
//  ViewController.swift
//  HackatonForGood
//
//  Created by Seto Elkahfi on 25/09/19.
//  Copyright © 2019 Seto Elkahfi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loginView: UIView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        loginView.layer.shadowColor = UIColor.black.cgColor
        loginView.layer.shadowOpacity = 1
        loginView.layer.shadowOffset = .zero
        loginView.layer.shadowRadius = 10
        
    }

    @IBAction func signUpButtonPressed(_ sender: Any) {
    }
    
    @IBAction func signInButtonPressed(_ sender: Any) {
    }
}

