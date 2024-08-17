//
//  ChatroomSettingsVM.swift
//  cheers
//
//  Created by Dong on 2024/3/19.
//

import SwiftUI

final class ChatroomSettingsVM: ObservableObject {
    @Published var members = [User]()
    @Published var friends = [User]()
    @Published var error: Error?
    
    func getFriends() {
        Task {
            await fetchFriends()
        }
    }
    
    func getMembers() async {
        do {
            let membersData = try await RequestWithAccessToken.send(
                "",
                methodType: .GET
            )
            
        } catch {
            self.error = error
        }
    }
    
    @MainActor
    func fetchFriends() async {
        do {
            friends = try await RequestWithAccessToken.send(
                "friend/getFriends",
                methodType: .GET
            )
        } catch {
            self.error = error
        }
    }
    
}
