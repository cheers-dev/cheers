//
//  URLRequest.swift
//  cheers
//
//  Created by Dong on 2024/4/5.
//

import Foundation
extension URLRequest {
    mutating func setBasicAuth(username: String, password: String) {
        let encodedAuthInfo = String(format: "%@:%@", username, password)
            .data(using: .utf8)!
            .base64EncodedString()
        
        addValue("Basic \(encodedAuthInfo)", forHTTPHeaderField: "Authorization")
    }
}
