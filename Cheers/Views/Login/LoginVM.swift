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
    
    func login() async throws {
        do {
            guard let endpointURLText = Bundle.main.infoDictionary?["LOGIN_URL"] as? String,
                  let loginURL = URL(string: endpointURLText.replacing("\\", with: "") + "/user/login")
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
            UserDefaults.standard.setValue(true, forKey: "accessTokenFound")
        } catch {
            self.error = error
        }
    }
}
