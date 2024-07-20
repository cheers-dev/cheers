//
//  FriendInvitation.swift
//  cheers
//
//  Created by Dong on 2024/7/21.
//

import Foundation

struct FrinedInvitation: Identifiable, Codable {
   
    let id: UUID
    let requestor: User
    let status: Status
    
    enum Status: String, Codable {
        case pending, accepted, rejected
    }
}
