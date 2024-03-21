//
//  Message.swift
//  cheers
//
//  Created by Dong on 2024/3/21.
//

import Foundation

struct Message: Identifiable, Codable {
    
    let id: Int
    let userId: Int
    let message: String
    let createTime: Date
    
}
