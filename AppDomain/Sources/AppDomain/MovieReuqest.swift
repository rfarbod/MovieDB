//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/11/24.
//

import Foundation

enum MovieRequest {
    case list(page: Int)
}

extension MovieRequest: RequestProtocol {
    var path: String {
        switch self {
        case .list:
            return "/movie/popular"
        }
    }

    var parameters: RequestParameters? {
        switch self {
        case let .list(page):
            return [
                "page": page
            ]
        }
    }

}
