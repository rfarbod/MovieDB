//
//  HomeModel.swift
//  MovieDB
//
//  Created by Farbod Rahiminik on 9/10/24.
//

import AppUI
import Foundation

public struct MoviesModel: ViewModelProtocol {
    public var isLoading: Bool
    public var items: [ItemThumbnailViewModel]

    init(
        isLoading: Bool = Self.default.isLoading,
        items: [ItemThumbnailViewModel] = Self.default.items
    ) {
        self.isLoading = isLoading
        self.items = items
    }
}

extension MoviesModel {
    public static var `default`: MoviesModel = .init(
        isLoading: true,
        items: []
    )
}
