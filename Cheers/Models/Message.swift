//
//  Message.swift
//  cheers
//
//  Created by Dong on 2024/3/21.
//

import Foundation

// MARK: - Message

struct Message: Identifiable, Codable {
    let id: UUID
    let userId: UUID
    let content: String
    let createdAt: Date?
    
    private static let dateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        return formatter
    }()
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.userId = try container.decode(UUID.self, forKey: .userId)
        self.content = try container.decode(String.self, forKey: .content)
        
        let createdAtString = try container.decode(String.self, forKey: .createdAt)
        self.createdAt = try Message.parseDate(createdAtString)
    }
    
    init(id: UUID, userId: UUID, content: String, createdAt: Date?) {
        self.id = id
        self.userId = userId
        self.content = content
        self.createdAt = createdAt
    }
    
    private static func parseDate(_ dateString: String) throws -> Date {
        let formattedString = dateString.replacingOccurrences(
            of: "\\.\\d+",
            with: "",
            options: .regularExpression
        )
        
        guard let date = dateFormatter.date(from: formattedString)
        else { throw APIError.invalidData }
        
        return date
    }
}

extension Message {
    static func dictionaryToMessage(_ dict: [String: String]) -> Message? {
        guard let id = UUID(uuidString: dict["id"] ?? ""),
              let userId = UUID(uuidString: dict["userId"] ?? ""),
              let content = dict["content"],
              let createdAtString = dict["createdAt"]?
              .replacingOccurrences(of: "\\.\\d+", with: "", options: .regularExpression),
              let createdAt = ISO8601DateFormatter().date(from: createdAtString)
        else { return nil }
        
        return Message(id: id, userId: userId, content: content, createdAt: createdAt)
    }
}
