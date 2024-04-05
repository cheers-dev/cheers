//
//  LoginVM.swift
//  Cheers
//
//  Created by Dong on 2024/3/18.
//

import SwiftUI

final class LoginVM: ObservableObject {
    @AppStorage("accessTokenFound") var accessTokenFound = KeychainManager.getToken("accessToken") != nil
    
    @Published var account = ""
    @Published var password = ""
    @Published var error: Error?
    
    func submit() {
        Task {
            try await login()
        }
    }
    
    func login() async throws {
        do {
            guard let loginURLText = Bundle.main.infoDictionary?["LOGIN_URL"] as? String,
                  let loginURL = URL(string: loginURLText.replacing("\\", with: ""))
            else { throw APIError.invalidURL }
            
            var request = URLRequest(url: loginURL)
            request.httpMethod = "GET"
            request.setBasicAuth(username: account, password: hashPassword(password))
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  200...299 ~= httpResponse.statusCode
            else { throw APIError.responseError }
            
            try KeychainManager.saveToken(
                String(data: data, encoding: .utf8)!,
                as: "accessToken"
            )
            accessTokenFound = true
        } catch {
            self.error = error
        }
    }
}
