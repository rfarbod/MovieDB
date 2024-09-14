//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/14/24.
//

import Foundation

public struct ItemDescriptionViewModel: ViewModelProtocol {
    public let title: String
    public let description: String
    public let voteAverage: Double
    public let voteCount: Int

    init(
        title: String,
        description: String,
        voteAverage: Double,
        voteCount: Int
    ) {
        self.title = title
        self.description = description
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}

extension ItemDescriptionViewModel {
    public static var `default`: ItemDescriptionViewModel = .init(
        title: "",
        description: "",
        voteAverage: 0,
        voteCount: 0
    )
}
