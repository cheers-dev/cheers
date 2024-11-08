//
//  CreateChatroomVM.swift
//  cheers
//
//  Created by Dong on 2024/3/20.
//

import Foundation
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

    private var loadingTask: Task<Void, Error>?

    init() {
        self.state = CreateChatroomState()
        self.getFriends()
    }

    deinit { loadingTask?.cancel() }

    func getFriends() {
        self.loadingTask?.cancel()
        self.loadingTask = Task { await self.fetchFriends() }
    }

    func createChatroom() async -> Bool {
        guard !self.state.name.isEmpty else {
            self.error = APIError.custom("chatroom should not be empty")
            return false
        }

        guard self.state.members.count > 1 else {
            self.error = APIError.custom("chatroom member should not be empty")
            return false
        }

        do {
            let body = try Chatroom.Create(
                id: UUID(),
                name: self.state.name,
                userIds: self.state.members.map { $0.id }
            )
            let data = try JSONEncoder().encode(body)

            let _: Chatroom = try await RequestWithAccessToken
                .send("chat/createChatroom", methodType: .POST, data: data)

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
