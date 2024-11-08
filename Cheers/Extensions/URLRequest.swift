//
//  URLRequest.swift
//  cheers
//
//  Created by Dong on 2024/4/5.
//

import Foundation
extension URLRequest {
    mutating func setBasicAuth(username: String, password: String) {
        guard !username.isEmpty, !password.isEmpty else { return }
        guard !username.contains(":") else { return }
        
        guard let authData = "\(username):\(password)".data(using: .utf8)
        else { return }
        let encodedAuthInfo = authData.base64EncodedString()
        
        addValue("Basic \(encodedAuthInfo)", forHTTPHeaderField: "Authorization")
    }
}
