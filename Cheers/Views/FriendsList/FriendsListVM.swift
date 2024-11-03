//
//  FriendsListVM.swift
//  cheers
//
//  Created by Dong on 2024/3/20.
//

import SwiftUI

final class FriendsListVM: ObservableObject {
    @Published var friends: [User] = []
    @Published var error: Error?
    
    init() {
        loadFriendList()
    }
    
    func loadFriendList() {
        Task { await fetchFriendList() }
    }
    
    @MainActor
    func fetchFriendList() async {
        do {
            let friends: [User] = try await RequestWithAccessToken
                .send("friend/getFriends", methodType: .GET)
            
            self.friends = friends
        } catch {
            self.error = error
        }
    }
}
