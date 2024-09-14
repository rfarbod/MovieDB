//
//  DetailsModel.swift
//  MovieDB
//
//  Created by Farbod Rahiminik on 9/13/24.
//

import AppUI
import Foundation

struct MovieDetailsModel: ViewModelProtocol {
    var isLoading: Bool
    let movieId: String
    var itemDetailsViewModel: ItemDetailsViewModel

    init(
        isLoading: Bool = Self.default.isLoading,
        movieId: String = Self.default.movieId,
        itemDetailsViewModel: ItemDetailsViewModel = Self.default.itemDetailsViewModel
    ) {
        self.isLoading = isLoading
        self.movieId = movieId
        self.itemDetailsViewModel = itemDetailsViewModel
    }
}

extension MovieDetailsModel {
    static var `default`: MovieDetailsModel = .init(
        isLoading: true,
        movieId: "",
        itemDetailsViewModel: .default
    )
}
