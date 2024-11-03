//
//  RegisterVM.swift
//  Cheers
//
//  Created by Dong on 2024/3/19.
//

import Foundation

final class RegisterVM: ObservableObject {
    @Published var account = ""
    @Published var password = ""
    @Published var mail = ""
    @Published var name = ""
    @Published var birth = Date()
    @Published var confirmPassword = ""
    @Published var error: Error?
    
    func submit() {
        Task {
            try await register()
        }
    }
    
    func register() async throws {
        do {
            guard password == confirmPassword
            else { throw APIError.custom("Password validation failed.") }
            
            guard let endpointURLText = Bundle.main.infoDictionary?["GATEWAY_URL"] as? String,
                  let registerURL = URL(
                      string: endpointURLText.replacingOccurrences(of: "\\", with: "") + "/user/register")
            else { throw APIError.invalidURL }
            
            var request = URLRequest(url: registerURL)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let createUser = User.Create(
                account: account,
                password: hashPassword(password),
                mail: mail,
                name: name,
                birth: birth.ISO8601Format(.iso8601Date(timeZone: .gmt))
            )
            
            let jsonData = try JSONEncoder().encode(createUser)
            request.httpBody = jsonData
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  200 ... 299 ~= httpResponse.statusCode
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
