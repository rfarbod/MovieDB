//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/11/24.
//

import Foundation

public enum APIError: Error, CustomStringConvertible, Equatable {
    case badRequest
    case authorizationError
    case serverError
    case unknown
    case invalidSelf

    public var description: String {
        switch self {
        case .badRequest:
            return "bad request"
        case .authorizationError:
            return "authorization error"
        case .serverError:
            return "server error"
        case .unknown:
            return "unknown error"
        case .invalidSelf:
            return "invalid self"
        }
    }
}
