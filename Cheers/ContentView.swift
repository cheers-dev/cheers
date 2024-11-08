//
//  ContentView.swift
//  Cheers
//
//  Created by Dong on 2024/3/18.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("accessTokenFound") var accessTokenFound = false

    var body: some View {
        if accessTokenFound { tabView }
        else { LoginView(login: LoginVM()) }
    }

    var tabView: some View {
        TabView {
            FriendsListView(friendsListVM: FriendsListVM())
                .tabItem {
                    Label("朋友", systemImage: "person.2.fill")
                }

            ChatroomListView(chatroomListVM: ChatroomListVM())
                .tabItem {
                    Label("聊天室", systemImage: "ellipsis.message.fill")
                }

            UserProfileView(
                avatarURL: URL(string: ""),
                name: "User name",
                birth: Date(),
                recentFavorite: ["燒肉", "火鍋", "漢堡"]
            )
            .tabItem {
                Label("用戶", systemImage: "person.fill")
            }
        }
    }
}

#Preview {
    ContentView()
}
