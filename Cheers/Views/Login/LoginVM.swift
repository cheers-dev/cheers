//
//  LoginVM.swift
//  Cheers
//
//  Created by Dong on 2024/3/18.
//

import SwiftUI

final class LoginVM: ObservableObject {
    @Published var account = ""
    @Published var password = ""
    @Published var error: Error?
    
    func submit() {
        Task {
            try await login()
        }
    }
    
    @MainActor
    func login() async throws {
        do {
            guard let endpointURLText = Bundle.main.infoDictionary?["GATEWAY_URL"] as? String,
                  let loginURL = URL(string: endpointURLText.replacing("\\", with: "") + "/user/login")
            else { throw APIError.invalidURL }
            
            var request = URLRequest(url: loginURL)
            request.httpMethod = "GET"
            request.setBasicAuth(username: account, password: hashPassword(password))
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  200...299 ~= httpResponse.statusCode
            else { throw APIError.responseError }
            
            guard let loginResponse = try? JSONDecoder().decode(User.LoginResponse.self, from: data)
            else { throw APIError.invalidData }
            
            try KeychainManager.saveToken(
                loginResponse.accessToken,
                as: "accessToken"
            )
            
            try KeychainManager.saveToken(
                "\(loginResponse.userId)",
                as: "userId"
            
            )
            UserDefaults.standard.setValue(true, forKey: "accessTokenFound")
        } catch {
            self.error = error
        }
    }
}
