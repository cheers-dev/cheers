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
            
            guard let registerURLText = Bundle.main.infoDictionary?["REGISTER_URL"] as? String,
                  let registerURL = URL(string: registerURLText.replacing("\\", with: ""))
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
            
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(createUser)
            request.httpBody = jsonData
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  200...299 ~= httpResponse.statusCode
            else { throw APIError.responseError }
            
            print(String(data: data, encoding: .utf8) ?? "")
        } catch {
            self.error = error
        }
    }
}
