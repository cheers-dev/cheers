//
//  GroupsListVM.swift
//  cheers
//
//  Created by Dong on 2024/3/20.
//

import SwiftUI

// MARK: - GroupsListState

struct GroupsListState {
    var groups = [Chatroom]()
    var loading: Bool = true
}

// MARK: - GroupsListVM

final class GroupsListVM: ObservableObject {
    @Published var state: GroupsListState
    @Published var error: Error? = nil

    init() {
        self.state = .init()
        getGroups()
    }

    func getGroups() {
        Task {
            await fetchGroups()
            state.loading = false
        }
    }

    @MainActor
    private func fetchGroups() async {
        do {
            let groups: [Chatroom.Info] = try await RequestWithAccessToken
                .send("chat/chatrooms", methodType: .GET)

            state.groups = groups.map { $0.chatroom }
        } catch { self.error = error }
    }
}
