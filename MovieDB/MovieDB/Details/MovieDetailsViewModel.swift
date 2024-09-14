//
//  MovieDetailsViewModel.swift
//  MovieDB
//
//  Created by Farbod Rahiminik on 9/13/24.
//

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

                let logos = movieDetails.productionCompanies?.compactMap({ productionCompany in
                    return (productionCompany.id, productionCompany.name, productionCompany.logoPath)
                }) ?? []

                let genres = movieDetails.genres?.compactMap({ genre in
                    return genre.name
                }) ?? []

                self.model.itemDetailsViewModel = .init(
                    imagePath: movieDetails.posterPath ?? "",
                    title: movieDetails.title ?? "",
                    description: movieDetails.overview ?? "",
                    logos: logos,
                    genres: genres,
                    rate: movieDetails.voteAverage ?? 0,
                    rateCount: movieDetails.voteCount ?? 0
                )
            })
            .store(in: &cancellables)
    }
}
