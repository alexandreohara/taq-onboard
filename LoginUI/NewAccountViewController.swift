//
//  NewAccountViewController.swift
//  LoginUI
//
//  Created by Taqtile on 14/05/18.
//  Copyright © 2018 Taqtile. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

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
        let vc: ViewController = ViewController()
        var isValid: Bool = true
        if (!containOnlyLetters(testStr: nameTextField.text!)) {
            nameTextField.layer.shadowColor = UIColor.red.cgColor
            nameError.isHidden = false
             isValid = false
        }
        else {
            nameTextField.layer.shadowColor = UIColor.gray.cgColor
            nameError.isHidden = true
        }
        if(!vc.isValidEmail(testStr: emailTextField.text!)) {
            emailTextField.layer.shadowColor = UIColor.red.cgColor
            emailError.isHidden = false
            isValid = false
        }
            
        else {
            emailTextField.layer.shadowColor = UIColor.gray.cgColor
            emailError.isHidden = true
        }
        
        if(passwordTextField.text!.count < 4) {
            passwordTextField.layer.shadowColor = UIColor.red.cgColor
            passwordError.isHidden = false
            isValid = false
        }
        else {
            passwordTextField.layer.shadowColor = UIColor.gray.cgColor
            passwordError.isHidden = true
        }
        if(passwordTextField.text! != confirmPassTextField.text!) {
            confirmPassTextField.layer.shadowColor = UIColor.red.cgColor
            confirmPasswordError.isHidden = false
            isValid = false
        }
        else {
            confirmPassTextField.layer.shadowColor = UIColor.gray.cgColor
            confirmPasswordError.isHidden = true
        }
        if(admSwitch.isOn) {
            userRole = "admin"
        }
        else {
            userRole = "user"
        }
        return isValid
    }
    
    func registerNewAccount() {
        guard let url = URL(string: "https://tq-template-server-sample.herokuapp.com/users") else {return}
        let header: HTTPHeaders = ["Authorization": UserDefaults.standard.string(forKey: "token")!]
        let params: [String: Any] = ["name": nameTextField.text!,
                                     "password": passwordTextField.text!,
                                     "email": emailTextField.text!,
                                     "role": userRole]
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            guard response.result.isSuccess else {
                print(response.result.error!)
                return
            }
            let json: JSON = JSON(response.result.value!)
            print(json)
        }
    }
    
    @IBAction func registerButton(_ sender: Any) {
        if (validateTextFields()) {
            registerNewAccount()
        }
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
        navigationItem.title = "Create new account"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
