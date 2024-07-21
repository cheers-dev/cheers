//
//  FriendInvitationsVM.swift
//  cheers
//
//  Created by Dong on 2024/3/20.
//

import Foundation

final class FriendInvitationsVM: ObservableObject {
    @Published var friendInvitations = [FriendInvitation]()
    @Published var error: Error?
    
    init() {
        loadFriendInvitations()
    }
    
    private func loadFriendInvitations() {
        Task {
            await fetchFriendInvitations()
        }
    }
    
    @MainActor
    private func fetchFriendInvitations() async {
        do{
            let friendInvitations: [FriendInvitation] = try await RequestWithAccessToken
                .get("/friend/getInvites")
            
            self.friendInvitations = friendInvitations
        } catch {
            self.error = error
        }
    }
}
