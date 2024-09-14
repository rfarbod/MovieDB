//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/10/24.
//

import Foundation

public struct ItemThumbnailViewModel: ViewModelProtocol {
    public let id: String
    public let title: String
    public let description: String
    public let imagePath: String
    public let rating: Double

    public init(
        id: String = Self.default.id,
        title: String = Self.default.title,
        description: String = Self.default.description,
        imagePath: String = Self.default.imagePath,
        rating: Double = Self.default.rating
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.imagePath = imagePath
        self.rating = rating
    }
}

extension ItemThumbnailViewModel {
    public static var `default`: ItemThumbnailViewModel = .init(
        id: "",
        title: "a movie",
        description: "a good movie",
        imagePath: "",
        rating: 0
    )
}


