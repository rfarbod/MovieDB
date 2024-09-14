//
//  MovieDetailsViewModel.swift
//  MovieDB
//
//  Created by Farbod Rahiminik on 9/13/24.
//

import AppUI
import AppDomain
import Combine
import Foundation

final class MovieDetailsViewModel {
    @Published var model: MovieDetailsModel
    private var movieAPI: MovieAPI = .init()

    private var cancellables = Set<AnyCancellable>()

    init(model: MovieDetailsModel) {
        self.model = model
    }

    func getMovieDetails() {
        model.isLoading = true

        movieAPI.details(id: model.movieId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    self.model.isLoading = false

                case let .failure(error):
                    self.model.isLoading = false
                    print("error getting movie details \(error)")
                }
            }, receiveValue: { [weak self] movieDetails in
                guard let self else { return }

                let logos: [SectionItem] = movieDetails.productionCompanies?.compactMap { .init(id: $0.id, title: $0.name, imagePath: $0.logoPath) } ?? []

                let genres: [SectionItem] = movieDetails.genres?.compactMap { .init(id: 0, title: $0.name, imagePath: "") } ?? []

                self.model.itemDetailsViewModel = .init(
                    imagePath: movieDetails.posterPath ?? "",
                    title: movieDetails.title ?? "",
                    description: movieDetails.overview ?? "",
                    sections: [
                        genres,
                        logos
                    ],
                    rate: movieDetails.voteAverage ?? 0,
                    rateCount: movieDetails.voteCount ?? 0
                )

                self.model.isLoading = false
            })
            .store(in: &cancellables)
    }
}
