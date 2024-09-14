//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/14/24.
//

import Combine
import Foundation

public class MockMovieAPI: MovieAPIProtocol {
    public var shouldReturnError = false
    public var moviesList: MovieResponse = .init(results: [], page: 1, totalPages: 10, totalResults: 100)
    public var movie: Movie = .init(id: 0, posterPath: nil, overview: nil, title: nil, voteAverage: nil, voteCount: nil, genres: [], productionCompanies: [])

    public init() {}

    public func list(page: Int) -> AnyPublisher<MovieResponse, Error> {
        if shouldReturnError {
            return Fail(error: URLError(.badServerResponse)).eraseToAnyPublisher()
        } else {
            return Just(moviesList)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }

    public func details(id: String) -> AnyPublisher<Movie, any Error> {
        if shouldReturnError {
            return Fail(error: URLError(.badServerResponse)).eraseToAnyPublisher()
        } else {
            return Just(movie)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
