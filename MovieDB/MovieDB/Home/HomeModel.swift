//
//  HomeModel.swift
//  MovieDB
//
//  Created by Farbod Rahiminik on 9/10/24.
//

import AppUI
import Foundation

struct HomeModel: ViewModelProtocol {
    var items: [ItemThumbnailViewModel]

    init(
        items: [ItemThumbnailViewModel] = Self.default.items
    ) {
        self.items = items
    }
}

extension HomeModel {
    static var `default`: HomeModel = .init(items: [])
}
