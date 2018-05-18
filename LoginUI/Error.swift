//
//  Error.swift
//  LoginUI
//
//  Created by Taqtile on 16/05/18.
//  Copyright © 2018 Taqtile. All rights reserved.
//

import Foundation

struct Error: Codable {
    let name: String?
    let original: String?
    let message: String?
}
