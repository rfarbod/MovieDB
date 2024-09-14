//
//  File.swift
//
//
//  Created by Farbod Rahiminik on 9/11/24.
//

import Combine
import Foundation

protocol MovieAPIProtocol {
    func list(page: Int) -> AnyPublisher<MovieResponse, Error>
    func details(id: String) -> AnyPublisher<Movie, Error>
}

public final class MovieAPI: MovieAPIProtocol {
    private let networkManager: NetworkManagerProtocol
    private let jsonDecoder: JSONDecoder

    public init(
        networkManager: NetworkManagerProtocol = NetworkManager.shared,
        jsonDecoder: JSONDecoder = JSONDecoder()
    ) {
        self.networkManager = networkManager
        self.jsonDecoder = jsonDecoder
    }

    public func list(page: Int) -> AnyPublisher<MovieResponse, Error> {
        networkManager.request(api: MovieRequest.list(page: page), retryCount: 4)
            .tryMap { [weak self] data in
                guard let self else { throw APIError.invalidSelf}
                return try self.jsonDecoder.decode(MovieResponse.self, from: data)
            }
            .eraseToAnyPublisher()
    }

    public func details(id: String) -> AnyPublisher<Movie, any Error> {
        networkManager.request(api: MovieRequest.details(id: id), retryCount: 4)
            .tryMap { [weak self] data in
                guard let self else { throw APIError.invalidSelf }
                return try self.jsonDecoder.decode(Movie.self, from: data)
            }
            .eraseToAnyPublisher()
    }
}
