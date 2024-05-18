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
    
    init () {
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
            guard let accessToken = KeychainManager.getToken("accessToken")
            else { throw KeychainError.itemNotFound }
            
            guard let endpointURLText = Bundle.main.infoDictionary?["GATEWAY_URL"] as? String,
                  let getChatroomListURL = URL(string: endpointURLText.replacing("\\", with: "") + "/chat/chatrooms")
            else { throw APIError.invalidURL }
            
            var request = URLRequest(url: getChatroomListURL)
            request.httpMethod = "GET"
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  200...299 ~= httpResponse.statusCode
            else { throw APIError.responseError }
            
            guard let chatroomList = try? JSONDecoder().decode([ChatroomInfo].self, from: data)
            else { throw APIError.invalidData }
            
            self.chatroomList = chatroomList
            
        } catch {
            self.error = error
        }
    }
    
    func filterChatroomWithName(_ query: String) -> [ChatroomInfo] {
        return chatroomList.filter { chatroom in
            chatroom.chatroom.name.contains(query)
        }
    }
}
