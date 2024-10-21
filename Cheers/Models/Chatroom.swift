//
//  Chatroom.swift
//  cheers
//
//  Created by Dong on 2024/3/21.
//

import Foundation

// MARK: - Chatroom

struct Chatroom: Identifiable, Codable {
    let id: UUID
    let name: String
    let avatar: URL?
}

// MARK: Chatroom.Create

extension Chatroom {
    struct Create: Identifiable, Codable {
        let id: UUID
        let name: String
        let userIds: [UUID]
        let avatar: URL?

        init(id: UUID, name: String, userIds: [UUID], avatar: URL? = nil) {
            self.id = id
            self.name = name
            self.avatar = avatar
            self.userIds = userIds
        }
    }
}

// MARK: Chatroom.Info

extension Chatroom {
    struct Info: Identifiable, Codable {
        let chatroom: Chatroom
        let lastMessage: Message?

        var id: UUID { chatroom.id }
    }
}
