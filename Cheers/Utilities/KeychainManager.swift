//
//  AccessToken.swift
//  cheers
//
//  Created by Dong on 2024/4/5.
//

import Foundation

//func setAccessToken(_ token: String) throws {
//    let tag = (Bundle.main.infoDictionary?["BASE_APPLICATION_TAG"] as? String)!.data(using: .utf8)!
//    let query: [String: Any] = [
//        kSecClass as String: kSecClassKey,
//        kSecAttrApplicationTag as String: tag,
//        kSecValueData as String: token.data(using: .utf8)!
//    ]
//    
//    let status = SecItemAdd(query as CFDictionary, nil)
//    guard status == errSecSuccess else { throw AccessTokenError.storingError}
//}
//
//func getAccessToken() -> String? {
//    let tag = (Bundle.main.infoDictionary?["BASE_APPLICATION_TAG"] as? String)!.data(using: .utf8)!
//    let getQuery: [String: Any] = [
//        kSecClass as String: kSecClassKey,
//        kSecAttrApplicationTag as String: tag,
//        kSecReturnData as String: true
//    ]
//    
//    var accessTokenData: AnyObject?
//    let status = SecItemCopyMatching(getQuery as CFDictionary, &accessTokenData)
//    
//    guard let accessToken = accessTokenData as? Data
//    else {
//        return nil
//    }
//            
//    return String(data: accessToken, encoding: .utf8)
//}

struct KeychainManager {
    static let tag = "dev.dongdong867.cheers.tokens"
    
    static func saveToken(_ token: String, as name: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: name,
            kSecAttrAccount as String: tag,
            kSecValueData as String: token.data(using: .utf8)!
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }
    }
    
    static func getToken(_ name: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: name,
            kSecAttrAccount as String: tag,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var tokenDataRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &tokenDataRef)
        
        guard status == errSecSuccess,
              let tokenData = tokenDataRef as? Data,
              let accessToken = String(data: tokenData, encoding: .utf8)
        else { return nil }
        
        return accessToken
    }
    
    static func deleteToken(_ name: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: name,
            kSecAttrAccount as String: tag
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess
        else { throw KeychainError.unexpectedStatus(status) }
    }
}
