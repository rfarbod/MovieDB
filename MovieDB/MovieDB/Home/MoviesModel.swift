//
//  HomeModel.swift
//  MovieDB
//
//  Created by Farbod Rahiminik on 9/10/24.
//

import AppUI
import Foundation

struct MoviesModel: ViewModelProtocol {
    var isLoading: Bool
    var items: [ItemThumbnailViewModel]

    init(
        isLoading: Bool = Self.default.isLoading,
        items: [ItemThumbnailViewModel] = Self.default.items
    ) {
        self.isLoading = isLoading
        self.items = items
    }
}

extension MoviesModel {
    static var `default`: MoviesModel = .init(
        isLoading: true,
        items: []
    )
}
