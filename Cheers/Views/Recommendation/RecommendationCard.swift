//
//  RecommendationCard.swift
//  cheers
//
//  Created by Tintin on 2024/9/9.
//

import Foundation

struct RecommendationCard: Decodable {
    let name: String
    let category: String
    let rating: Double
    let address: String
    let phone: String
    let price: String
    let opening_time: String?
}
