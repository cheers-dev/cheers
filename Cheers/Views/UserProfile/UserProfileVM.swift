//
//  UserProfileVM.swift
//  cheers
//
//  Created by Tintin on 2024/10/21.
//

import Foundation

final class UserProfileVM: ObservableObject {
    let chatroomListVM = ChatroomListVM()
    @Published var chatInteractionCards: [ChatInteractionCard] = []
    @Published var recommendInteractionCards: [RecommendInteractionCard] = []
    @Published var error: Error?
    
    init(){
        
    }
    
    func fetchRecommendationList() async {
        print("fetchRecommendationList started")
        do {
            guard let accessToken = KeychainManager.getToken("accessToken")
            else { throw KeychainError.itemNotFound }
            
            guard let endpointURLText = Bundle.main.infoDictionary?["GATEWAY_URL"] as? String,
                  let getChatroomListURL = URL(string: endpointURLText.replacing("\\", with: "") + "/chat/recommendationList")
            else { throw APIError.invalidURL }
            
            var request = URLRequest(url: getChatroomListURL)
            request.httpMethod = "GET"
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  200...299 ~= httpResponse.statusCode
            else { throw APIError.responseError }
            
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            guard let recommendList = try? decoder.decode([RecommendationInfo].self, from: data)
            else { throw APIError.invalidData }

            DispatchQueue.main.async {
                recommendList.forEach { recommend in
                    if let date = recommend.lastRecommend {
                        self.recommendInteractionCards.append(
                            RecommendInteractionCard(
                                chatroomId: recommend.chatroom.id,
                                chatroomName: recommend.chatroom.name,
                                date: self.formatToTaiwanTime(from: date),
                                timePassed: self.calculateTimePassed(from: date)
                            )
                        )
                    } else {
                        print("No last message found for chatroom: \(recommend.chatroom.name)")
                    }
                }
            }
        } catch {
            print("Error in fetchRecommendationList: \(error)")
            DispatchQueue.main.async {
                self.error = error
            }
        }
    }
    
    func mapChatroomChatInteractionCard() {
        if chatroomListVM.chatroomList.isEmpty {
            print("No chatrooms found")
            return
        }
        
        let chatroomList = chatroomListVM.filterChatroomWithChatFrequency()
        var interactionCards: [ChatInteractionCard] = []
        
        chatroomList.forEach { chatroomInfo in
            if let createdAt = chatroomInfo.lastMessage?.createdAt {
                interactionCards.append(
                    ChatInteractionCard(
                        chatroomId: chatroomInfo.id,
                        chatroomName: chatroomInfo.chatroom.name,
                        date: formatToTaiwanTime(from: createdAt),
                        timePassed: calculateTimePassed(from: createdAt)
                    )
                )            } else {
                print("No last message found for chatroom: \(chatroomInfo.chatroom.name)")
            }
        }
        
        DispatchQueue.main.async {
            self.chatInteractionCards = interactionCards
        }
            
    }
    
    func calculateTimePassed(from date: Date) -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        
        // 計算年、週、天、時、分鐘
        let years = calendar.dateComponents([.year], from: date, to: currentDate).year ?? 0
        let weeks = calendar.dateComponents([.weekOfYear], from: date, to: currentDate).weekOfYear ?? 0
        let days = calendar.dateComponents([.day], from: date, to: currentDate).day ?? 0
        let hours = calendar.dateComponents([.hour], from: date, to: currentDate).hour ?? 0
        let minutes = calendar.dateComponents([.minute], from: date, to: currentDate).minute ?? 0
        
        var timePassed = ""
        
        if years > 0 {
            timePassed += "\(years)年"
        } else if weeks > 0 {
            timePassed += "\(weeks)週"
        } else if days > 0 {
            timePassed += "\(days)天"
        } else if hours > 0 {
            timePassed += "\(hours)小時"
        } else if minutes > 0 {
            timePassed += "\(minutes)分鐘"
        }
        
        return timePassed
    }
    
    func formatToTaiwanTime(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Taipei")
        
        return dateFormatter.string(from: date)
    }
    
}
