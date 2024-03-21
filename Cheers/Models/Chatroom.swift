//
//  Chatroom.swift
//  cheers
//
//  Created by Dong on 2024/3/21.
//

import Foundation

struct Chatroom: Identifiable, Codable {
    
    let id: Int
    let name: String
    let avatar: URL?
    var messages: [Message]
    
}
