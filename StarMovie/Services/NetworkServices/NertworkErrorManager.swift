//
//  NertworkErrorManager.swift
//  StarMovie
//
//  Created by petar on 03.10.2024.
//

import Foundation

enum NetworkErrors: Error {
    case invalidURL
    case invalidData
    case invalidJSON
    case networkConnectionError
    case timeOutError
    case trailerNotFound
    case unknownError
}

final class NertworkErrorManager {
    
    func defineError(error: URLError) -> NetworkErrors {
        switch error.code {
        case .notConnectedToInternet:
            return .networkConnectionError
        case .timedOut:
            return .timeOutError
        default:
            return .unknownError
        }
    }
}
