//
//  NewAccountViewController.swift
//  LoginUI
//
//  Created by Taqtile on 14/05/18.
//  Copyright © 2018 Taqtile. All rights reserved.
//

import UIKit

class NewAccountViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    @IBOutlet weak var nameError: UILabel!
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var confirmPasswordError: UILabel!
    @IBOutlet weak var admSwitch: UISwitch!
    
    var userRole: String = ""
    
    fileprivate func validateTextFields() -> Bool {
        
        let validate: FormValidator = FormValidator()
        var isValid: Bool = true
        
        nameTextField.layer.shadowColor = validate.containOnlyLetters(testStr: nameTextField.text!) ? UIColor.gray.cgColor : UIColor.red.cgColor
        nameError.isHidden = validate.containOnlyLetters(testStr: nameTextField.text!) ? true : false
        
        emailTextField.layer.shadowColor = validate.isValidEmail(testStr: emailTextField.text!) ? UIColor.gray.cgColor : UIColor.red.cgColor
        emailError.isHidden = validate.isValidEmail(testStr: emailTextField.text!) ? true : false
        
        passwordTextField.layer.shadowColor = !validate.isValidPassword(testStr: passwordTextField.text!) ? UIColor.red.cgColor : UIColor.gray.cgColor
        passwordError.isHidden = !validate.isValidPassword(testStr: passwordTextField.text!) ? false : true
        
        confirmPassTextField.layer.shadowColor = passwordTextField.text! != confirmPassTextField.text! ? UIColor.red.cgColor : UIColor.gray.cgColor
        confirmPasswordError.isHidden = passwordTextField.text! != confirmPassTextField.text! ? false : true
        
        if (!validate.containOnlyLetters(testStr: nameTextField.text!) || !validate.isValidEmail(testStr: emailTextField.text!) ||
            !validate.isValidPassword(testStr: passwordTextField.text!) || passwordTextField.text! != confirmPassTextField.text!) {isValid = false}
        
        userRole = admSwitch.isOn ? "admin" : "user"
        return isValid
    }
    
    @IBAction func registerButton(_ sender: Any) {
        if (validateTextFields()) {
            let account = CreateAccount()
            let params: [String: Any] = ["name": nameTextField.text!,
                                         "password": passwordTextField.text!,
                                         "email": emailTextField.text!,
                                         "role": userRole]
            account.registerNewAccount(params: params)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.setBottomBorder()
        emailTextField.setBottomBorder()
        passwordTextField.setBottomBorder()
        confirmPassTextField.setBottomBorder()
        navigationItem.title = "Create new account"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
