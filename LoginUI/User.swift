//
//  User.swift
//  LoginUI
//
//  Created by Taqtile on 16/05/18.
//  Copyright © 2018 Taqtile. All rights reserved.
//

import Foundation

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
