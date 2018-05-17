//
//  ViewController.swift
//  LoginUI
//
//  Created by Taqtile on 03/05/18.
//  Copyright © 2018 Taqtile. All rights reserved.
//

import UIKit
import TransitionButton

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailError: UILabel!

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var button: TransitionButton!
    
    fileprivate func validateLogin() -> Bool {
        let validate: FormValidator = FormValidator()
        var isValid = true
        
        emailTextField.layer.shadowColor = validate.isValidEmail(testStr: emailTextField.text!) ? UIColor.gray.cgColor : UIColor.red.cgColor
        emailError.isHidden = validate.isValidEmail(testStr: emailTextField.text!)
        
        passwordTextField.layer.shadowColor = validate.isValidPassword(testStr: passwordTextField.text!) ? UIColor.gray.cgColor : UIColor.red.cgColor
        passwordError.isHidden = validate.isValidPassword(testStr: passwordTextField.text!)
        
        if (!validate.isValidEmail(testStr: emailTextField.text!) ||
            !validate.isValidPassword(testStr: passwordTextField.text!)) {isValid = false}
        return isValid
    }
    
    @IBAction func login(_ sender: Any) {
        errorMessage.isHidden = true
        if (validateLogin()) {
            button.startAnimation()
            
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            
            let loginService: LoginService = LoginService()
            loginService.remoteLogin(email: emailTextField.text!, password: passwordTextField.text!, completion: { (success) -> Void in
                DispatchQueue.main.async {
                    if success {
                        self.activityIndicator.stopAnimating()
                        self.button.stopAnimation(animationStyle: .expand, completion: {
                            self.performSegue(withIdentifier: "goToWelcome", sender: self)
                        })
                    }
                    else {
                        self.errorMessage.isHidden = false
                        self.activityIndicator.stopAnimating()
                        self.button.stopAnimation(animationStyle: .shake, completion: {
                        })
                    }
                }
            })
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.setBottomBorder()
        passwordTextField.setBottomBorder()
        button.cornerRadius = 10
        
        
        
    }    
}
