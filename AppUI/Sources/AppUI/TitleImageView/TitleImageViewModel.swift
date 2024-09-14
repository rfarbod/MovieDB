//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/13/24.
//

import Foundation

public struct TitleImageViewModel: ViewModelProtocol {
    public let title: String
    public let imagePath: String

    public init(
        title: String = Self.default.title,
        imagePath: String = Self.default.imagePath
    ) {
        self.title = title
        self.imagePath = imagePath
    }
}

extension TitleImageViewModel {
    public static var `default`: TitleImageViewModel = .init(
        title: "",
        imagePath: ""
    )
}

