//
//  ChatroomListView.swift
//  cheers
//
//  Created by Dong on 2024/3/19.
//

import SwiftUI

struct ChatroomListView: View {
    @State var search = ""
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    ChatroomView()
                } label: {
                    ChatCardView(
                        imageURL: URL(string: ""),
                        name: "Name",
                        lastMessage: "testing message",
                        time: Date()
                    )
                    .padding(.trailing)
                }
            }
            .listStyle(.plain)
            .navigationTitle("聊天室")
            .toolbarBackground(Color(UIColor.systemGray6), for: .navigationBar)
            .toolbar {
                NavigationLink(destination: CreateChatroomView()) {
                    Image(systemName: "ellipsis.message.fill")
                        .foregroundStyle(.black)
                }
            }
        }
        .searchable(text: $search)
        .navigationBarTitleDisplayMode(.large)
    }
}
#Preview {
    ChatroomListView()
}
