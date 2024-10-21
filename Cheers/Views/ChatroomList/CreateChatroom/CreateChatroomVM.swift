//
//  CreateChatroomVM.swift
//  cheers
//
//  Created by Dong on 2024/3/20.
//

import SwiftUI

// MARK: - CreateChatroomState

final class CreateChatroomState {
    var members = [User]()
    var friends = [User]()
    var name = ""
}

// MARK: - CreateChatroomVM

final class CreateChatroomVM: ObservableObject {
    @Published var state: CreateChatroomState
    @Published var error: Error? = nil

    init() {
        self.state = CreateChatroomState()
        self.getFriends()
    }

    func getFriends() {
        Task { await self.fetchFriends() }
    }

    func createChatroom() async -> Bool {
        do {
            let body = Chatroom.Create(
                id: UUID(),
                name: self.state.name,
                userIds: self.state.members.map { $0.id }
            )
            let data = try JSONEncoder().encode(body)

            let chatroom: Chatroom = try await RequestWithAccessToken
                .send("chat/createChatroom", methodType: .POST, data: data)
            
            print(chatroom)
            return true
        } catch {
            self.error = error
            return false
        }
    }

    @MainActor
    private func fetchFriends() async {
        do {
            let friends: [User] = try await RequestWithAccessToken
                .send("friend/getFriends", methodType: .GET)
            self.state.friends = friends
        } catch {
            self.error = error
        }
    }
}
