//
//  APIError.swift
//  cheers
//
//  Created by Dong on 2024/4/4.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    case invalidURL
    case responseError
    case invalidData
    case custom(String)
    case unknown(String)

    public var description: String {
        switch self {
            case .invalidURL:
                "API endpoint isn't a valid URL."
            case .responseError:
                "API response status code isn't 200."
            case .invalidData:
                "API response data can't be decode into the given model."
            case .custom(let message):
                message
            case .unknown(let message):
                message
        }
    }
}
