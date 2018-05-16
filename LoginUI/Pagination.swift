//
//  Pagination.swift
//  LoginUI
//
//  Created by Taqtile on 16/05/18.
//  Copyright © 2018 Taqtile. All rights reserved.
//

import Foundation

struct Pagination: Codable {
    let page: Int?
    let window: Int?
    let total: Int?
    let totalPages: Int?
}
