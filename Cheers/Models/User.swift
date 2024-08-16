//
//  User.swift
//  cheers
//
//  Created by Dong on 2024/3/20.
//

import Foundation

struct User: Identifiable, Codable {
    
    let id: UUID
    let mail: String
    let account: String
    let name: String
    let birth: Date?
    let avatar: URL?
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.mail = try container.decode(String.self, forKey: .mail)
        self.account = try container.decode(String.self, forKey: .account)
        self.name = try container.decode(String.self, forKey: .name)
        self.avatar = try container.decodeIfPresent(URL.self, forKey: .avatar)
        
        if let birthString = try container.decodeIfPresent(String.self, forKey: .birth) {
            self.birth = try DateStringDecoder.decode(birthString)
        } else { self.birth = nil }
    }
    
    init(
        id: UUID,
        mail: String,
        account: String,
        name: String,
        birth: Date? = nil,
        avatar: URL?
    ) {
        self.id = id
        self.mail = mail
        self.account = account
        self.name = name
        self.birth = birth
        self.avatar = avatar
    }
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
        id: UUID(),
        mail: "dummy@example.com",
        account: "dummy",
        name: "Dummy", 
        birth: Date(),
        avatar: nil
    )
}
