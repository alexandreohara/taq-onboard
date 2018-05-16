//
//  UserService.swift
//  LoginUI
//
//  Created by Taqtile on 16/05/18.
//  Copyright © 2018 Taqtile. All rights reserved.
//

import UIKit

class UserService {
    func getUserProfile(id: Int, completion: @escaping(Profile) -> ()) {
        let baseUrl = "https://tq-template-server-sample.herokuapp.com/users/" + String(id)
        
        guard let url = URL(string: baseUrl) else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(UserDefaults.standard.string(forKey: "token"), forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            var responseDatabase: Profile
            if let requestError = error {
                print(requestError)
                return
            }
            
            guard let data = data else { return }
            do {
                
                let decoder = JSONDecoder()
                let response = try decoder.decode(Profile.self, from: data)
                
                if response.data != nil {
                    responseDatabase = response
                    completion(responseDatabase)
                }
                
            } catch let err {
                print(err)
                return
            }
        }
        task.resume()
    }
}


