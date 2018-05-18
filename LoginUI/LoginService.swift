//
//  LoginService.swift
//  LoginUI
//
//  Created by Taqtile on 16/05/18.
//  Copyright © 2018 Taqtile. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LoginService {
    
    var error: String = ""
    func login(email: String, password: String, completion: @escaping (Bool)->()) {
        guard let url = URL(string: "https://tq-template-server-sample.herokuapp.com/authenticate") else {return}
        let params = ["email": email,
                      "password": password,
                      "rememberMe": false] as [String : Any]
        let header: HTTPHeaders = ["Content-type": "application/json"]
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            guard response.result.isSuccess else {
                print(response.result.error!)
                completion(false)
                return
            }
            let json: JSON = JSON(response.result.value!)
            if let data = json["data"].dictionary {
                UserDefaults.standard.set(data["user"]!["name"].string, forKey: "userName")
                UserDefaults.standard.set(data["token"]!.string, forKey: "token")
                completion(true)
            }
            else{
                self.error = json["errors"][0]["message"].string!
                completion(false)
            }
        }
    }
}
