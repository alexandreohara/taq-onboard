//
//  CreateAccount.swift
//  LoginUI
//
//  Created by Taqtile on 16/05/18.
//  Copyright © 2018 Taqtile. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Account {
    func create(params: [String: Any]) {
        guard let url = URL(string: "https://tq-template-server-sample.herokuapp.com/users") else {return}
        let header: HTTPHeaders = ["Authorization": UserDefaults.standard.string(forKey: "token")!]
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            guard response.result.isSuccess else {
                print(response.result.error!)
                return
            }
            let json: JSON = JSON(response.result.value!)
            print(json)
        }
    }
    
}
