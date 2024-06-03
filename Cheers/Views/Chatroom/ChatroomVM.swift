//
//  ChatroomVM.swift
//  cheers
//
//  Created by Dong on 2024/3/19.
//

import SwiftUI
import SocketIO

final class ChatroomVM: ObservableObject {
    
    @Published var page = 1
    @Published var loading = true
    @Published var error: Error?
    @Published var messages: [Message] = []
    @Published var chatroom: Chatroom
    
    private var socketManager: SocketManager
    private var socket: SocketIOClient
    
    // MARK: - Constructor
    
    init(chatroom: Chatroom) {
        self.chatroom = chatroom
        
        let socketURLText = Bundle.main.infoDictionary!["SOCKET_URL"] as! String
        let socketURL = URL(string: socketURLText.replacing("\\", with: ""))!
        
        self.socketManager = SocketManager(socketURL: socketURL, config: [.log(true), .compress])
        self.socket = self.socketManager.defaultSocket
        self.loadMessages()
        self.setupSocketEvent()
        self.socket.connect()
    }
    
    deinit {
        socket.disconnect()
    }
    
    // MARK: - Messages
    
    func loadMessages() {
        Task {
            await fetchMessage()
            page += 1
        }
    }
    
    @MainActor
    private func fetchMessage() async {
        do {
            guard let accessToken = KeychainManager.getToken("accessToken")
            else { throw KeychainError.itemNotFound }
            
            guard let endpointURLText = Bundle.main.infoDictionary?["GATEWAY_URL"] as? String,
                  let getChatroomListURL = URL(string: endpointURLText.replacing("\\", with: "") + "/chat/messages/\(self.chatroom.id)?page=\(page)")
            else { throw APIError.invalidURL }
            
            var request = URLRequest(url: getChatroomListURL)
            request.httpMethod = "GET"
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  200...299 ~= httpResponse.statusCode
            else { throw APIError.responseError }
            
            guard let messages = try? JSONDecoder().decode([Message].self, from: data)
            else { throw APIError.invalidData }
            
            self.messages = messages
        } catch {
            self.error = error
        }
    }
    
    func sendMessage(_ message: String) {
        let userId = "c3c28a01-84cc-4f29-9ff5-e1b7e4a2a2bc"
        
        let payload: [String: Any] = [
            "userId": userId,
            "chatroomId": chatroom.id.uuidString,
            "content": message
        ]
        
        emitSendMessageEvent(payload)
    }
    
    // MARK: - Socket
    
    private func setupSocketEvent() {
        self.socket.on(clientEvent: .connect) { _, _ in
            self.socket.emit("connectToChatroom", "\(self.chatroom.id)")
        }
        
        self.socket.on(clientEvent: .disconnect) { _, _ in

        }
        
        self.socket.on(clientEvent: .error) { data, _ in
            print(String(describing: data.first))
        }
        
        self.socket.on("chatroomConnected") { data, _ in
            self.loading = false
        }
        
        self.socket.on("error") { data, _ in
            print("chatroom error \(data)")
            self.error = SocketError.unknownError(message: "\(String(describing: data.first))")
        }
        
        self.socket.on("message") { data, _ in
            guard let messageDict = data[0] as? Dictionary<String, String>,
                  let message = Message.dictionaryToMessage(messageDict)
            else {
                print("error on messageDict")
                self.error = SocketError.messageDecodeError
                return
            }
            
            self.messages.append(message)
        }
    }
    
    private func connectToChatroom() {
        self.socket.emit("connectToChatroom", "\(chatroom.id)")
    }
    
    private func emitSendMessageEvent(_ payload: [String: Any]) {
        self.socket.emit("sendMessage", payload)
    }
    
}
