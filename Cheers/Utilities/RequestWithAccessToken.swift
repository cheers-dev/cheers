//
//  RequestWithAccessToken.swift
//  cheers
//
//  Created by Dong on 2024/7/22.
//

import Foundation

struct RequestWithAccessToken {
    
    static func send(_ route: String, methodType: Method) async throws -> Data{
        guard let accessToken = KeychainManager.getToken("accessToken")
        else { throw KeychainError.itemNotFound }
        
        guard let endpointURLText = Bundle.main.infoDictionary?["GATEWAY_URL"] as? String,
              let requestURL = URL(string: endpointURLText.replacing("\\", with: "") + route)
        else { throw APIError.invalidURL }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = methodType.rawValue
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200...299 ~= httpResponse.statusCode
        else { throw APIError.responseError }
        
        return data
    }
    
    static func send<T: Decodable>(_ route: String, methodType: Method) async throws -> T {
        let data = try await send(route, methodType: methodType)
        
        guard let responseJSON = try? JSONDecoder().decode(T.self, from: data)
        else { throw APIError.invalidData }
        
        return responseJSON
    }
    
    enum Method: String {
        case GET, POST, PUT, DELETE, PATCH
    }
}
