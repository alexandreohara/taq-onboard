//
//  LoginService.swift
//  LoginUI
//
//  Created by Taqtile on 16/05/18.
//  Copyright © 2018 Taqtile. All rights reserved.
//

import Foundation

class LoginService {
    var loginResult: Bool = false
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
                }

            } catch let err {
                print(err)
            }
            completion(self.loginResult)
        }
        task.resume()
    }
}
