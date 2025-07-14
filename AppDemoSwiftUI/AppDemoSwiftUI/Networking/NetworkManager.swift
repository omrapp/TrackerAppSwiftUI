//
//  NetworkManager.swift
//  AppDemoSwiftUI
//
//  Created by Omar Ayed on 18/05/2025.
//

import SwiftUI

enum Endpoint {
    
    case users, posts
    
    var url: String {
        
        switch self {
        case .users:
            return "https://jsonplaceholder.typicode.com/users"
        case .posts:
            return "https://jsonplaceholder.typicode.com/posts"
        }
    }
}

enum APIError: LocalizedError {
    
    case notConnectedToInternet, badURL, decodingError, serverError(Int)
    
    var errorDescription: String? {
        switch self {
            case .notConnectedToInternet: return "No Internet Connection"
            case .badURL: return "Invalid URL"
            case .decodingError: return "Failed to decode response"
            case .serverError(let code): return "Server Error: \(code)"
        }
    }
}


final class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchData<T: Decodable>(from api: Endpoint) async throws -> T {
        
        return try await fetchData(from: api.url)
    }
    
    
    func fetchData<T: Decodable>(from url: String) async throws -> T {
        
        guard let url = URL(string: url)  else {
            throw APIError.badURL
        }
        
        return try await fetchData(from: url)
    }
    
    
    func fetchData<T: Decodable>(from url: URL) async throws -> T {
        
        
        guard let (data, response) = try? await URLSession.shared.data(from: url) else {
            throw  APIError.notConnectedToInternet
        }
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw APIError.serverError((response as? HTTPURLResponse)?.statusCode ?? 500)
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.decodingError
        }
    }
    
    
}
