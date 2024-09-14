//
//  HomeViewModel.swift
//  MovieDB
//
//  Created by Farbod Rahiminik on 9/10/24.
//

import AppDomain
import Combine
import Foundation

public final class MoviesViewModel {
    @Published public var model: MoviesModel
    public var movieAPI: MovieAPIProtocol
    private var currentPage: Int = 1

    private var cancellables = Set<AnyCancellable>()

    public init(
        movieAPI: MovieAPIProtocol,
        model: MoviesModel
    ) {
        self.movieAPI = movieAPI
        self.model = model
    }

    public func getItems() {
        model.isLoading = true
        
        currentPage += 1
        movieAPI.list(page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    self.model.isLoading = false

                case let .failure(error):
                    self.model.isLoading = false
                    print("error getting movies \(error)")
                }
            }, receiveValue: { [weak self] moviesList in
                guard let self else { return }
                moviesList.results?.forEach({ movie in
                    self.model.items.append(.init(
                        id: "\(movie.id)",
                        title: movie.title ?? "",
                        description: movie.overview ?? "",
                        imagePath: movie.posterPath ?? "",
                        rating: movie.voteAverage ?? 0
                    ))
                })
            })
            .store(in: &cancellables)
    }
}
