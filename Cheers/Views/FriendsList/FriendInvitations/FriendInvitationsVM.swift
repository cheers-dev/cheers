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
    
    private var loadingTask: Task<Void, Never>?
    
    init() {
        Task { @MainActor in
            await self.fetchFriendInvitations()
        }
    }
    
    deinit { loadingTask?.cancel() }
    
    func acceptInvitation(_ id: UUID) async {
        await handleInvitation(id, action: "accept")
    }
    
    func rejectInvitation(_ id: UUID) async {
        await handleInvitation(id, action: "reject")
    }
    
    @MainActor
    private func fetchFriendInvitations() async {
        do {
            let friendInvitations: [FriendInvitation] = try await RequestWithAccessToken
                .send("friend/getInvites", methodType: .GET)
            
            self.friendInvitations = friendInvitations
        } catch {
            self.error = error
        }
    }
    
    private func handleInvitation(_ id: UUID, action: String) async {
        do {
            let _ = try await RequestWithAccessToken
                .send("friend/\(action)?id=\(id)", methodType: .PATCH)
            
            await MainActor.run {
                self.friendInvitations.removeAll { $0.id == id }
            }
        } catch {
            await MainActor.run {
                self.error = error
            }
        }
    }
}
