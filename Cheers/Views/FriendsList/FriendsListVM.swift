//
//  FriendsListVM.swift
//  cheers
//
//  Created by Dong on 2024/3/20.
//

import SwiftUI

final class FriendsListVM: ObservableObject {
    @Published var friends: [User] = []
    @Published var error: Error?
    
    init() {
        loadFriendList()
    }
    
    func loadFriendList() {
        Task { await fetchFriendList() }
    }
    
    @MainActor
    func fetchFriendList() async {
        do {
            guard let accessToken = KeychainManager.getToken("accessToken")
            else { throw KeychainError.itemNotFound }
            
            guard let endpointURLText = Bundle.main.infoDictionary?["GATEWAY_URL"] as? String,
                  let getFriendListURL = URL(string: endpointURLText.replacing("\\", with: "") + "/friend/getFriends")
            else { throw APIError.invalidURL }
            
            var request = URLRequest(url: getFriendListURL)
            request.httpMethod = "GET"
            request.setValue(accessToken, forHTTPHeaderField: "Authorization")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  200...299 ~= httpResponse.statusCode
            else { throw APIError.responseError }
            
            guard let friends = try? JSONDecoder().decode([User].self, from: data)
            else { throw APIError.invalidData }
            
            self.friends = friends
            
        } catch {
            self.error = error
        }
    }
}
