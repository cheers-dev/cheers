//
//  SocketError.swift
//  cheers
//
//  Created by Dong on 2024/5/19.
//

import Foundation

enum SocketError: Error {
    case messageDecodeError
    case unknownError(message: String)
    
    func description() -> String {
        switch self {
            case .messageDecodeError:
                "Failed to decode received message."
            case .unknownError(let message):
                message
        }
    }
}
