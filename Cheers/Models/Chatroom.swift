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

        init(id: UUID, name: String, userIds: [UUID], avatar: URL? = nil) throws {
            let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
            guard trimmedName.isEmpty
                && userIds.count > 2
                && Set(userIds).count == userIds.count
            else { throw APIError.invalidData }

            self.id = id
            self.name = trimmedName
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
