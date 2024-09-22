//
//  Message.swift
//  cheers
//
//  Created by Dong on 2024/3/21.
//

import Foundation

struct Message: Identifiable, Codable {
    
    let id: UUID
    let userId: UUID
    let content: String
    let createdAt: Date?
    let name: String // message with sender name
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.userId = try container.decode(UUID.self, forKey: .userId)
        self.content = try container.decode(String.self, forKey: .content)
        
        let createdAtString = (try container.decode(String.self, forKey: .createdAt))
                                .replacingOccurrences(of: "\\.\\d+", with: "", options:.regularExpression)
        self.createdAt = ISO8601DateFormatter().date(from: createdAtString)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? "unknown sender" // message with sender name
    }
    
    init(id: UUID, userId: UUID, content: String, createdAt: Date?, name: String) {
        self.id = id
        self.userId = userId
        self.content = content
        self.createdAt = createdAt
        self.name = name
    }
}


extension Message {
    
    static func dictionaryToMessage(_ dict: [String: String]) -> Message? {
        guard let id = UUID(uuidString: dict["id"] ?? ""),
              let userId = UUID(uuidString: dict["userId"] ?? ""),
              let content = dict["content"],
              let createdAtString = dict["createdAt"]?
                                        .replacingOccurrences(of: "\\.\\d+", with: "", options:.regularExpression),
              let createdAt = ISO8601DateFormatter().date(from: createdAtString),
              let name = dict["name"]
        else { return nil }
        
        return Message(id: id, userId: userId, content: content, createdAt: createdAt, name: name)
    }
}
