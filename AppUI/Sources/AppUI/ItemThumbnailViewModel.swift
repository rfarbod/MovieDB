//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/10/24.
//

import Foundation

public struct ItemThumbnailViewModel: ViewModelProtocol {
    public let title: String
    public let description: String
    public let imagePath: String
    public let rating: Double

    public init(
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
    public static var `default`: ItemThumbnailViewModel = .init(
        title: "a movie",
        description: "a good movie",
        imagePath: "",
        rating: 0
    )
}


