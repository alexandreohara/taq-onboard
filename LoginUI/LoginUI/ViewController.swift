//
//  ViewController.swift
//  LoginUI
//
//  Created by Taqtile on 03/05/18.
//  Copyright © 2018 Taqtile. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
   
    
    @IBAction func button(_ sender: Any) {
        if(!isValidEmail(testStr: email.text!)) {
            print("Email inválido")
        }
        if(password.text!.count < 4) {
            print("Senha inválida")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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

}

