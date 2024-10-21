//
//  ChatInteractionCard.swift
//  cheers
//
//  Created by Tintin on 2024/10/21.
//

import Foundation

struct ChatInteractionCard: Decodable {
    let chatroomId: UUID
    let chatroomName: String
    let date: String
    let timePassed: String
}
