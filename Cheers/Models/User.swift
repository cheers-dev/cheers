//
//  User.swift
//  cheers
//
//  Created by Dong on 2024/3/20.
//

import Foundation

struct User: Identifiable {
    var id: String
    
    let mail: String
    let account: String
    let name: String
    let birth: Date
    let avatar: URL?
}
