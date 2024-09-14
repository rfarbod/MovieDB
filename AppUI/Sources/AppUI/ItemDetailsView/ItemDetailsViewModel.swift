//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/13/24.
//

import Foundation

public struct ItemDetailsViewModel: ViewModelProtocol {
    public typealias Logos = [(Int, String, String)]
    public typealias Genres = [String]

    public let imagePath: String
    public let title: String
    public let description: String
    public let logos: Logos
    public let genres: Genres
    public let rate: Double
    public let rateCount: Int
    public let onScroll: ((CGFloat) -> Void)?

    public init(
        imagePath: String = Self.default.imagePath,
        title: String = Self.default.title,
        description: String = Self.default.description,
        logos: Logos = Self.default.logos,
        genres: Genres = Self.default.genres,
        rate: Double = Self.default.rate,
        rateCount: Int = Self.default.rateCount,
        onScroll: ((CGFloat) -> Void)? = Self.default.onScroll
    ) {
        self.imagePath = imagePath
        self.title = title
        self.description = description
        self.logos = logos
        self.genres = genres
        self.rate = rate
        self.rateCount = rateCount
        self.onScroll = onScroll
    }
}

extension ItemDetailsViewModel {
    public static var `default`: ItemDetailsViewModel = .init(
        imagePath: "",
        title: "",
        description: "",
        logos: [],
        genres: [],
        rate: 0,
        rateCount: 0,
        onScroll: nil
    )
}
