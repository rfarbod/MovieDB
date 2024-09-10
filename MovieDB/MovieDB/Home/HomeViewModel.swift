//
//  HomeViewModel.swift
//  MovieDB
//
//  Created by Farbod Rahiminik on 9/10/24.
//

import Foundation

final class HomeViewModel {
    @Published var model: HomeModel = .default

    init(model: HomeModel) {
        self.model = model
    }

    func getItems() {
        model = .init(items: [
            .default,
            .default,
            .default,
            .default,
            .init(title: "Something to see")
        ])
    }
}
