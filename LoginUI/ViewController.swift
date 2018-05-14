//
//  ViewController.swift
//  LoginUI
//
//  Created by Taqtile on 03/05/18.
//  Copyright © 2018 Taqtile. All rights reserved.
//

import UIKit

struct Database: Codable {
    let data: [User]?
    let pagination: Pagination?
}

struct Profile: Codable {
    let data: User?
}

struct Pagination: Codable {
    let page: Int?
    let window: Int?
    let total: Int?
    let totalPages: Int?
}

struct Login: Codable {
    let data: Data?
    let errors: [Error]?
}

struct Data: Codable {
    let user: User?
    let token: String?

}

struct Error: Codable {
    let name: String?
    let original: String?
    let message: String?
}


struct User: Codable {
    let id: Int?
    let active: Bool?
    let email: String?
    let activationToken: String?
    let createdAt: String?
    let updatedAt: String?
    let salt: String?
    let name: String?
    let role: String?
    
}

class ViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailError: UILabel!

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorMessage: UILabel!
    
    var loginResult = false
    
    
    @IBAction func button(_ sender: Any) {
        if(!isValidEmail(testStr: emailTextField.text!)) {
            print("Email inválido")
            emailTextField.layer.shadowColor = UIColor.red.cgColor
            emailError.isHidden = false
            
        }
        
        else {
            emailTextField.layer.shadowColor = UIColor.gray.cgColor
            emailError.isHidden = true
        }
        
        if(passwordTextField.text!.count < 4) {
            print("Senha inválida")
            passwordTextField.layer.shadowColor = UIColor.red.cgColor
            passwordError.isHidden = false
        }
        else {
            passwordTextField.layer.shadowColor = UIColor.gray.cgColor
            passwordError.isHidden = true
        }
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        remoteLogin(email: emailTextField.text!, password: passwordTextField.text!, completion: { (success) -> Void in
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
        // Do any additional setup after loading the view, typically from a nib.
        
        emailTextField.setBottomBorder()
        passwordTextField.setBottomBorder()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func remoteLogin(email: String, password: String, completion: @escaping (Bool)->()) {
        loginResult = false
        guard let url = URL(string: "https://tq-template-server-sample.herokuapp.com/authenticate") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        let postDictionary = ["email": email,
                              "password": password,
                              "rememberMe": false] as [String : Any]
        do {
            let jsonBody = try JSONSerialization.data(withJSONObject: postDictionary, options: [])
            request.httpBody = jsonBody
        } catch{}
        
        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            
            if let requestError = error {
                print(requestError)
                return
            }
            
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Login.self, from: data)
                
                if response.data != nil {
                    UserDefaults.standard.set(response.data?.user?.name, forKey: "userName")
                    UserDefaults.standard.set(response.data?.token, forKey: "token")
                    self.loginResult = true
                    completion(self.loginResult)
                }
                else {
                    DispatchQueue.main.async {
                        completion(self.loginResult)
                        self.errorMessage.text! = response.errors![0].message!
                        return
                    }
                }

                
            } catch let err {
                completion(self.loginResult)
                print(err)
                return
            }
        }
        task.resume()
    }
    
    
    
}

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}



