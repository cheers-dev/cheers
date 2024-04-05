//
//  ContentView.swift
//  Cheers
//
//  Created by Dong on 2024/3/18.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("accessTokenFound") var accessTokenFound = KeychainManager.getToken("accessToken") != nil
    
    var body: some View {
        Group {
            if accessTokenFound {
                TabView {
                    FriendsListView()
                        .tabItem {
                            Label("朋友", systemImage: "person.2.fill")
                        }
                    
                    ChatsView()
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
            } else {
                LoginView(login: LoginVM())
            }
        }
    }
}

#Preview {
    ContentView()
}
