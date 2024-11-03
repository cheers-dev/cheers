//
//  ChatroomListVM.swift
//  cheers
//
//  Created by Dong on 2024/3/19.
//

import Foundation

final class ChatroomListVM: ObservableObject {
    @Published var chatroomList: [ChatroomInfo] = []
    @Published var error: Error?
    
    init() {
        loadChatroomList()
    }
    
    func loadChatroomList() {
        Task {
            await fetchChatroomList()
        }
    }
    
    @MainActor
    func fetchChatroomList() async {
        do {
            let chatroomList: [ChatroomInfo] = try await RequestWithAccessToken
                .send("chat/chatrooms", methodType: .GET)
            
            self.chatroomList = chatroomList
        } catch { self.error = error }
    }
    
    func filterChatroomWithName(_ query: String) -> [ChatroomInfo] {
        return chatroomList.filter { chatroom in
            chatroom.chatroom.name.lowercased().contains(query.lowercased())
        }
    }
}
