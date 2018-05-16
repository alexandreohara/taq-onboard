//
//  ViewController.swift
//  LoginUI
//
//  Created by Taqtile on 03/05/18.
//  Copyright © 2018 Taqtile. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailError: UILabel!

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorMessage: UILabel!
    
    fileprivate func validateLogin() {
        let validate: FormValidator = FormValidator()
        emailTextField.layer.shadowColor = !validate.isValidEmail(testStr: emailTextField.text!) ? UIColor.red.cgColor : UIColor.gray.cgColor
        emailError.isHidden = !validate.isValidEmail(testStr: emailTextField.text!) ? false : true
        
        passwordTextField.layer.shadowColor = !validate.isValidPassword(testStr: passwordTextField.text!) ? UIColor.red.cgColor : UIColor.gray.cgColor
        passwordError.isHidden = !validate.isValidPassword(testStr: passwordTextField.text!) ? false : true
    }
    
    @IBAction func button(_ sender: Any) {
        validateLogin()
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        let login: LoginService = LoginService()
        login.remoteLogin(email: emailTextField.text!, password: passwordTextField.text!, completion: { (success) -> Void in
            DispatchQueue.main.async {
                if success {
                    self.performSegue(withIdentifier: "goToWelcome", sender: self)
                    self.activityIndicator.stopAnimating()
                }
                else{
                    self.errorMessage.isHidden = false
                    self.activityIndicator.stopAnimating()
                }
            }
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.setBottomBorder()
        passwordTextField.setBottomBorder()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
