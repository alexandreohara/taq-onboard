//
//  UserService.swift
//  LoginUI
//
//  Created by Taqtile on 16/05/18.
//  Copyright © 2018 Taqtile. All rights reserved.
//

import UIKit
import Alamofire

class UserListService {
    func getList(page: Int, window: Int, completion: @escaping(Database) -> ()) {
        let baseUrl = "https://tq-template-server-sample.herokuapp.com/users"
        let queryItemPage = URLQueryItem(name: "pagination", value: "{\"page\": \(page) , \"window\": \(window)}")
        guard var url = URLComponents(string: baseUrl) else {return}
        url.queryItems = [queryItemPage]
        let header: HTTPHeaders = ["Authorization": UserDefaults.standard.string(forKey: "token")!]
        
        Alamofire.request(url.url!, method: .get, parameters: nil, encoding: JSONEncoding.default , headers: header).responseData{ (response) in
            guard response.result.isSuccess else {
                print(response.result.error!)
                return
            }
            guard let data = response.result.value else {return}
            do {
                let decoder = JSONDecoder()
                let databaseResponse = try decoder.decode(Database.self, from: data)
                if databaseResponse.data != nil {
                    completion(databaseResponse)
                }
            }
            catch let err{
                print(err)
            }
        }
    }
}
