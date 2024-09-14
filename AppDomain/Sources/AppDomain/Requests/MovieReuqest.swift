//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/11/24.
//

import Foundation

enum MovieRequest {
    case list(page: Int)
    case details(id: String)
}

extension MovieRequest: RequestProtocol {
    var path: String {
        switch self {
        case .list:
            return "/movie/popular"

        case let .details(id):
            return "/movie/\(id)"
        }
    }

    var parameters: RequestParameters? {
        switch self {
        case let .list(page):
            return [
                "page": page,
                "api_key" : "55957fcf3ba81b137f8fc01ac5a31fb5"
            ]

        case .details:
            return [
                "api_key" : "55957fcf3ba81b137f8fc01ac5a31fb5"
            ]
        }
    }

}
