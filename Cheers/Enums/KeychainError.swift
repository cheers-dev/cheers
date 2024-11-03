//
//  KeychainError.swift
//  cheers
//
//  Created by Dong on 2024/4/5.
//

import Foundation

enum KeychainError: Error {
    case itemNotFound
    case invalidData
    case duplicateItem
    case unexpectedStatus(OSStatus)
}
