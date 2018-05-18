//
//  UserService.swift
//  LoginUI
//
//  Created by Taqtile on 16/05/18.
//  Copyright © 2018 Taqtile. All rights reserved.
//

import UIKit
import Alamofire

class UserService {
    func getProfile(id: Int, completion: @escaping(Profile) -> ()) {
        let baseUrl = "https://tq-template-server-sample.herokuapp.com/users/" + String(id)
        guard let url = URL(string: baseUrl) else {return}
        let header: HTTPHeaders = ["Authorization": UserDefaults.standard.string(forKey: "token")!]
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default , headers: header).responseData{ (response) in
            guard response.result.isSuccess else {
                print(response.result.error!)
                return
            }
            guard let data = response.result.value else {return}
            do {
                let decoder = JSONDecoder()
                let profileResponse = try decoder.decode(Profile.self, from: data)
                completion(profileResponse)
            }
            catch let err {
                print(err)
            }
        }
    }
}


