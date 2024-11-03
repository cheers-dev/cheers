//
//  HashPassword.swift
//  cheers
//
//  Created by Dong on 2024/4/4.
//

import CryptoKit
import Foundation

func hashPassword(_ password: String) -> String {
    let data = Data(password.utf8)
    let digest = SHA256.hash(data: data)
    let hashedPassword = digest.compactMap {
        String(format: "%02x", $0)
    }.joined()
    
    return hashedPassword
}
