//
//  TwoChoicesVM.swift
//  cheers
//
//  Created by 楊晏禎 on 2024/10/15.
//

import Foundation

final class TwoChoicesVM: ObservableObject {
    @Published var foods = ["中式", "甜點", "日式", "美式", "越式", "義式", "韓式", "港式", "泰式", "法式", "西式", "東南亞", "異國料理", "酒吧"]
    @Published var rankings: [String] = []
    @Published var currentFood: String = ""
    @Published var comparisonIndex: Int = 0
    @Published var showResult = false
    @Published var error: Error?

    @Published var foodScores: [String: Int] = [:]

    func startComparison() {
        if foods.count > 1 {
            rankings = [foods[0]]
            currentFood = foods[1]
            comparisonIndex = 0
        }
    }

    func makeChoice(_ preferredIndex: Int) {
        if preferredIndex == 0 {
            comparisonIndex += 1
            if comparisonIndex >= rankings.count {
                rankings.append(currentFood)
                if rankings.count < foods.count {
                    currentFood = foods[rankings.count]
                    comparisonIndex = 0
                }
            }
        } else {
            rankings.insert(currentFood, at: comparisonIndex)
            if rankings.count < foods.count {
                currentFood = foods[rankings.count]
                comparisonIndex = 0
            }
        }

        if rankings.count == foods.count {
            calculateScores()
            showResult = true
            saveRankings()
        }
    }

    func calculateScores() {
        let maxScore = foods.count
        for (index, food) in rankings.enumerated() {
            foodScores[food] = maxScore - index
        }
    }

    func saveRankings() {
        Task {
            do {
                try await postRankingsToServer()
            } catch {
                DispatchQueue.main.async {
                    self.error = error
                }
            }
        }
    }

    func postRankingsToServer() async throws {
        do {
            guard let endpointURLText = Bundle.main.infoDictionary?["GATEWAY_URL"] as? String,
                  let rankingURL = URL(string: endpointURLText.replacing("\\", with: "") + "/user/rankings")
            else { throw APIError.invalidURL }
            
            guard let userId = KeychainManager.getToken("userId")
            else { throw APIError.invalidData }

            var request = URLRequest(url: rankingURL)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            let rankingData = foodScores.map { food, score in
                return RankingEntry(food: food, score: score)
            }

            let rankingPayload = RankingPayload(userId: userId, rankings: rankingData)
            
            let jsonData = try JSONEncoder().encode(rankingPayload)
            request.httpBody = jsonData

            let (_, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse,
                  200...299 ~= httpResponse.statusCode
            else {
                throw APIError.responseError }

        } catch {
            throw error
        }
    }
}

struct RankingPayload: Codable {
    let userId: String
    let rankings: [RankingEntry]
}

struct RankingEntry: Codable {
    let food: String
    let score: Int
}

