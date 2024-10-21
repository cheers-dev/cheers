//
//  RecommendationInfo.swift
//  cheers
//
//  Created by Tintin on 2024/10/22.
//

import Foundation

struct RecommendationInfo: Identifiable, Codable {
    
    var chatroom: Chatroom
    var lastRecommend: Date?
    
    var id: UUID { chatroom.id }
}
