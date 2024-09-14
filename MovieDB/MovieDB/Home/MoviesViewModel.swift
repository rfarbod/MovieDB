//
//  HomeViewModel.swift
//  MovieDB
//
//  Created by Farbod Rahiminik on 9/10/24.
//

import AppDomain
import AppUI
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
        
        cancellables.forEach { $0.cancel() }
        movieAPI.list(page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    self.model.isLoading = false
                    self.currentPage += 1

                case let .failure(error):
                    self.model.isLoading = false
                    print("error getting movies \(error)")
                }
            }, receiveValue: { [weak self] moviesList in
                guard
                    let self,
                    let results = moviesList.results,
                    self.currentPage == moviesList.page
                else { return }

                print(self.currentPage)
                let newItems: [ItemThumbnailViewModel] = results.map({ movie in
                        .init(
                            id: "\(movie.id)",
                            title: movie.title ?? "",
                            description: movie.overview ?? "",
                            imagePath: movie.posterPath ?? "",
                            rating: movie.voteAverage ?? 0
                        )
                })
                self.model.items += newItems
            })
            .store(in: &cancellables)
    }
}
