//
//  NSMutableData.swift
//  cheers
//
//  Created by Dong on 2024/4/2.
//

import Foundation

extension NSMutableData {
    func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
