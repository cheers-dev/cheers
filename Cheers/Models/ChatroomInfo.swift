//
//  ChatroomInfo.swift
//  cheers
//
//  Created by Dong on 2024/3/21.
//

import Foundation

struct ChatroomInfo: Identifiable, Codable {
    
    let id: UUID
    let name: String
    let avatar: URL?
    var lastMessage: Message?
    
}
