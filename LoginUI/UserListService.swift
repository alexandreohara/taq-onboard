//
//  UserService.swift
//  LoginUI
//
//  Created by Taqtile on 16/05/18.
//  Copyright © 2018 Taqtile. All rights reserved.
//

import UIKit

class UserListService {
    func getUserList(page: Int, window: Int, completion: @escaping(Database) -> ()) {
        let baseUrl = "https://tq-template-server-sample.herokuapp.com/users"
        let queryItemPage = URLQueryItem(name: "pagination", value: "{\"page\": \(page) , \"window\": \(window)}")
        
        guard var url = URLComponents(string: baseUrl) else {return}
        url.queryItems = [queryItemPage]
        
        var request = URLRequest(url: url.url!)
        request.httpMethod = "GET"
        request.setValue(UserDefaults.standard.string(forKey: "token"), forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            var responseDatabase: Database
            if let requestError = error {
                print(requestError)
                return
            }
            
            guard let data = data else { return }
            do {
                
                let decoder = JSONDecoder()
                let response = try decoder.decode(Database.self, from: data)
                
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
