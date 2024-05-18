//
//  ChatroomListView.swift
//  cheers
//
//  Created by Dong on 2024/3/19.
//

import SwiftUI

struct ChatroomListView: View {
    @ObservedObject var chatroomListVM: ChatroomListVM
    
    @State var search = ""
    @State var showErrorAlert = false
    
    var body: some View {
        NavigationStack {
            List(search.isEmpty
                 ? chatroomListVM.chatroomList
                 : chatroomListVM.filterChatroomWithName(search)
            ) { chatroomInfo in
                NavigationLink {
                    ChatroomView()
                } label: {
                    ChatCardView(
                        imageURL: chatroomInfo.chatroom.avatar,
                        name: chatroomInfo.chatroom.name,
                        lastMessage: chatroomInfo.lastMessage,
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
        .onReceive(chatroomListVM.$error) { error in
            if error != nil {
                showErrorAlert.toggle()
            }
        }
        .alert("Error", isPresented: $showErrorAlert) {
            Button(action: { showErrorAlert.toggle() }) {
                Text("OK")
            }
        } message: {
            if chatroomListVM.error != nil {
                Text(String(describing: chatroomListVM.error!))
            }
        }
    }
}
#Preview {
    ChatroomListView(chatroomListVM: ChatroomListVM())
}
