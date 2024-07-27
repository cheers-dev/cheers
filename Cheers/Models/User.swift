//
//  User.swift
//  cheers
//
//  Created by Dong on 2024/3/20.
//

import Foundation

struct User: Identifiable, Codable {
    
    let mail: String
    let account: String
    let name: String
    let birth: Date?
    let avatar: URL?
    
    var id: String { account }
}

extension User {
    struct Create: Codable {
        let account: String
        let password: String
        let mail: String
        let name: String
        let birth: String
    }
    
    struct LoginResponse: Codable {
        let accessToken: String
        let userId: UUID
    }
}

extension User {
    static var dummy = User(
        mail: "dummy@example.com",
        account: "dummy",
        name: "Dummy", 
        birth: Date(),
        avatar: nil
    )
}
