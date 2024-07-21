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
            let _ = try await RequestWithAccessToken.send(
                "friend/accept?id=\(id)",
                methodType: .PATCH
            )
            
            self.friendInvitations.removeAll { invitation in
                invitation.id == id
            }
        } catch {
            self.error = error
        }
    }
    
    func rejectInvitation(_ id: UUID) async {
        do {
            let _ = try await RequestWithAccessToken.send(
                "friend/reject?id=\(id)",
                methodType: .PATCH
            )
            
            self.friendInvitations.removeAll { invitation in
                invitation.id == id
            }
        } catch {
            self.error = error
        }
    }
    
    @MainActor
    private func fetchFriendInvitations() async {
        do{
            let friendInvitations: [FriendInvitation] = try await RequestWithAccessToken
                .send("/friend/getInvites", methodType: .GET)
            
            self.friendInvitations = friendInvitations
        } catch {
            self.error = error
        }
    }
}
