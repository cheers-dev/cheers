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
    
    func acceptInvitation(_ id: UUID) async {
        do {
            let _ = try await RequestWithAccessToken.get("/friend/accept?id=\(id)")
        } catch {
            self.error = error
        }
    }
    
    func rejectInvitation(_ id: UUID) async {
        do {
            let _ = try await RequestWithAccessToken.get("/friend/reject?id=\(id)")
        } catch {
            self.error = error
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
