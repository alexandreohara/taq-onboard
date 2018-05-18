//
//  Database.swift
//  LoginUI
//
//  Created by Taqtile on 16/05/18.
//  Copyright © 2018 Taqtile. All rights reserved.
//

import Foundation

struct Database: Codable {
    let data: [User]?
    let pagination: Pagination?
}
