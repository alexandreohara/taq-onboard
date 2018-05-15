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
        
        nameTextField.layer.shadowColor = containOnlyLetters(testStr: nameTextField.text!) == true ? UIColor.gray.cgColor : UIColor.red.cgColor
        nameError.isHidden = containOnlyLetters(testStr: nameTextField.text!) == true ? true : false
        
        emailTextField.layer.shadowColor = vc.isValidEmail(testStr: emailTextField.text!) == true ? UIColor.gray.cgColor : UIColor.red.cgColor
        emailError.isHidden = vc.isValidEmail(testStr: emailTextField.text!) == true ? true : false
        
        passwordTextField.layer.shadowColor = passwordTextField.text!.count < 4 ? UIColor.red.cgColor : UIColor.gray.cgColor
        passwordError.isHidden = passwordTextField.text!.count < 4 ? false : true
        
        confirmPassTextField.layer.shadowColor = passwordTextField.text! != confirmPassTextField.text! ? UIColor.red.cgColor : UIColor.gray.cgColor
        confirmPasswordError.isHidden = passwordTextField.text! != confirmPassTextField.text! ? false : true
        
        if (containOnlyLetters(testStr: nameTextField.text!) == false || vc.isValidEmail(testStr: emailTextField.text!) == true ||
            passwordTextField.text!.count < 4 || passwordTextField.text! != confirmPassTextField.text!) {isValid = false}
        
        userRole = admSwitch.isOn ? "admin" : "user"
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
