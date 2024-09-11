//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/11/24.
//

import Foundation
import Combine

public protocol NetworkManagerProtocol {
    func request(api: RequestProtocol, retryCount: Int) -> AnyPublisher<Data, Error>
}

public class NetworkManager: NetworkManagerProtocol {
    static public let shared = NetworkManager()
    let urlSession: URLSession

    private init(config: URLSessionConfiguration = .default) {
        self.urlSession = URLSession(configuration: config)
    }

    public func request(api: RequestProtocol, retryCount: Int) -> AnyPublisher<Data, Error> {
        guard let apiRequest = api.urlRequest() else {
            return Fail(error: APIError.badRequest).eraseToAnyPublisher()
        }
        return urlSession.dataTaskPublisher(for: apiRequest)
            .retry(retryCount)
            .tryMap { (data, response) in
                try api.verifyResponse(data: data, response: response)
            }
            .eraseToAnyPublisher()
    }
}
