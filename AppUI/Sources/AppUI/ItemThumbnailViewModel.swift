//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/10/24.
//

import Foundation

struct ItemThumbnailViewModel: ViewModelProtocol {
    let title: String
    let description: String
    let imagePath: String
    let rating: Double

    init(
        title: String = Self.default.title,
        description: String = Self.default.description,
        imagePath: String = Self.default.imagePath,
        rating: Double = Self.default.rating
    ) {
        self.title = title
        self.description = description
        self.imagePath = imagePath
        self.rating = rating
    }
}

extension ItemThumbnailViewModel {
    static var `default`: ItemThumbnailViewModel = .init(title: "", imagePath: "", rating: 0.0)
}


