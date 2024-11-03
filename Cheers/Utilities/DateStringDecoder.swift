//
//  DateStringDecoder.swift
//  cheers
//
//  Created by Dong on 2024/7/28.
//

import Foundation

struct DateStringDecoder {
    
    static func decode(_ dateString: String) throws -> Date {
        let dateFormatter = ISO8601DateFormatter()
        
        if let date = dateFormatter.date(from: dateString) {
            return date
        } else {
            throw APIError.invalidData
        }
    }
}
