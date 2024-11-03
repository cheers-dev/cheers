//
//  ChatroomInfo.swift
//  cheers
//
//  Created by Dong on 2024/3/21.
//

import Foundation

struct ChatroomInfo: Identifiable, Codable {
    
    var chatroom: Chatroom
    var lastMessage: Message?
    
    var id: UUID { chatroom.id }
}
