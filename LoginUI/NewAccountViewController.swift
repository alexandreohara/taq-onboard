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
    
    fileprivate func validateTextFields() {
        let vc: ViewController = ViewController()
        if (!containOnlyLetters(testStr: nameTextField.text!)) {
            nameTextField.layer.shadowColor = UIColor.red.cgColor
            nameError.isHidden = false
        }
        else {
            nameTextField.layer.shadowColor = UIColor.gray.cgColor
            nameError.isHidden = true
        }
        if(!vc.isValidEmail(testStr: emailTextField.text!)) {
            emailTextField.layer.shadowColor = UIColor.red.cgColor
            emailError.isHidden = false
        }
            
        else {
            emailTextField.layer.shadowColor = UIColor.gray.cgColor
            emailError.isHidden = true
        }
        
        if(passwordTextField.text!.count < 4) {
            passwordTextField.layer.shadowColor = UIColor.red.cgColor
            passwordError.isHidden = false
        }
        else {
            passwordTextField.layer.shadowColor = UIColor.gray.cgColor
            passwordError.isHidden = true
        }
        if(passwordTextField.text! != confirmPassTextField.text!) {
            confirmPassTextField.layer.shadowColor = UIColor.red.cgColor
            confirmPasswordError.isHidden = false
        }
        else {
            confirmPassTextField.layer.shadowColor = UIColor.gray.cgColor
            confirmPasswordError.isHidden = true
        }
    }
    
    @IBAction func registerButton(_ sender: Any) {
        validateTextFields()
    }
    
    func containOnlyLetters(testStr: String) -> Bool {
        for chr in testStr {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") ) {
                return false
            }
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.setBottomBorder()
        emailTextField.setBottomBorder()
        passwordTextField.setBottomBorder()
        confirmPassTextField.setBottomBorder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
