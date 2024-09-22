//
//  ChatroomVM.swift
//  cheers
//
//  Created by Dong on 2024/3/19.
//

import SocketIO
import SwiftUI

final class ChatroomVM: ObservableObject {
    @Published var page = 1
    @Published var loading = true
    @Published var error: Error?
    @Published var hasMore = true
    @Published var messages: [Message] = []
    @Published var recommendations: [RecommendationCard] = []
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
        self.setupSocketEvent()
        self.socket.connect()
    }
    
    deinit {
        socket.disconnect()
    }
    
    // MARK: - Messages
    
    func loadMessages() {
        Task {
            let messages = await fetchMessage()
            self.messages.insert(contentsOf: messages, at: 0)
            self.page += 1
            
            if messages.count < 30 {
                self.hasMore = false
            }
        }
    }
    
    private func fetchMessage() async -> [Message] {
        do {
            let messages: [Message] = try await RequestWithAccessToken
                .send("chat/messages/\(self.chatroom.id)?page=\(self.page)", methodType: .GET)
            
            return messages.sorted(by: { $0.createdAt! < $1.createdAt! })
        } catch {
            self.error = error
            return []
        }
    }
    
    func sendMessage(_ message: String) {
        guard let userId = KeychainManager.getToken("userId")
        else {
            do {
                try KeychainManager.deleteToken("accessToken")
            } catch {
                self.error = error
            }
            
            self.error = KeychainError.itemNotFound
            return
        }
        
        let payload: [String: Any] = [
            "userId": userId,
            "chatroomId": chatroom.id.uuidString,
            "content": message
        ]
        
        self.emitSendMessageEvent(payload)
    }
    
    // MARK: - Socket
    
    private func setupSocketEvent() {
        self.socket.on(clientEvent: .connect) { _, _ in
            self.socket.emit("connectToChatroom", "\(self.chatroom.id)")
        }
        
        self.socket.on(clientEvent: .error) { data, _ in
            print(String(describing: data.first))
        }
        
        self.socket.on("chatroomConnected") { _, _ in
            self.loading = false
        }
        
        self.socket.on("error") { data, _ in
            print("chatroom error \(data)")
            self.error = SocketError.unknownError(message: "\(String(describing: data.first))")
        }
        
        self.socket.on("message") { data, _ in
            guard let messageDict = data[0] as? [String: String],
                  let message = Message.dictionaryToMessage(messageDict)
            else {
                print("error on messageDict")
                self.error = SocketError.messageDecodeError
                return
            }
            
            self.messages.append(message)
        }
        
        self.socket.on("recommend") { data, _ in
            guard let responses = data[0] as? [[String: Any]]
            else {
                print("Error: Data is not a valid string dictionary")
                return
            }
            
            let recommendations = responses.compactMap { dict -> RecommendationCard? in
                guard
                    let name = dict["name"] as? String,
                    let category = dict["category"] as? String,
                    let rating = dict["rating"] as? Double,
                    let address = dict["address"] as? String,
                    let phone = dict["phone"] as? String,
                    let price = dict["price"] as? String
                else {
                    return nil
                }

                return RecommendationCard(
                    name: name,
                    category: category,
                    rating: rating,
                    address: address,
                    phone: phone,
                    price: price
                )
            }
                
            DispatchQueue.main.async {
                self.recommendations = recommendations
                print("Received recommendations: \(responses)")
            }
        }
    }
    
    private func connectToChatroom() {
        self.socket.emit("connectToChatroom", "\(self.chatroom.id)")
    }
    
    private func emitSendMessageEvent(_ payload: [String: Any]) {
        self.socket.emit("sendMessage", payload)
    }
}
