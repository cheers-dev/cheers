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
            chatroomList
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
    
    var chatroomList: some View {
        List(search.isEmpty
             ? chatroomListVM.chatroomList
             : chatroomListVM.filterChatroomWithName(search)
        ) { chatroomInfo in
            NavigationLink {
                ChatroomView(chatroomVM: ChatroomVM(chatroom: chatroomInfo.chatroom))
            } label: {
                ChatroomCardView(
                    imageURL: chatroomInfo.chatroom.avatar,
                    name: chatroomInfo.chatroom.name,
                    lastMessage: chatroomInfo.lastMessage,
                    time: chatroomInfo.lastMessage?.createdAt
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
}

#Preview {
    ChatroomListView(chatroomListVM: ChatroomListVM())
}
