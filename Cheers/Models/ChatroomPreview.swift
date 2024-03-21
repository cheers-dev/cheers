//
//  ChatroomPreview.swift
//  cheers
//
//  Created by Dong on 2024/3/21.
//

import Foundation

struct ChatroomPreview: Identifiable, Codable {
    
    let id: Int
    let name: String
    let avatar: URL?
    var unread: Bool
//    var lastMessage: Message
    
}
