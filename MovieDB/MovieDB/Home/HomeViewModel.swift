//
//  HomeViewModel.swift
//  MovieDB
//
//  Created by Farbod Rahiminik on 9/10/24.
//

import AppDomain
import Combine
import Foundation

final class HomeViewModel {
    @Published var model: HomeModel
    private var movieAPI: MovieAPI = .init()

    private var cancellables = Set<AnyCancellable>()

    init(model: HomeModel) {
        self.model = model
    }

    func getItems() {
        movieAPI.list(page: 1)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    self.model.isLoading = false

                case let .failure(_):
                    self.model.isLoading = false
                }
            }, receiveValue: { [weak self] moviesList in
                guard let self else { return }
                moviesList.results?.forEach({ movie in
                    self.model.items.append(.init(
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
