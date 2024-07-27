//
//  FriendInvitation.swift
//  cheers
//
//  Created by Dong on 2024/7/21.
//

import Foundation

struct FriendInvitation: Identifiable, Codable {
   
    let id: UUID
    var requestor: User
    var status: Status
}

extension FriendInvitation {
    enum Status: String, Codable {
        case pending, accepted, rejected
    }
}

extension FriendInvitation {
    static var dummy = FriendInvitation(
        id: UUID(),
        requestor: User.dummy,
        status: .pending
    )
}
