//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/13/24.
//

import Foundation

public struct ItemDetailsViewModel: ViewModelProtocol {
    public let imagePath: String
    public let title: String
    public let description: String
    public let sections: [[SectionItem]]
    public let rate: Double
    public let rateCount: Int

    public init(
        imagePath: String = Self.default.imagePath,
        title: String = Self.default.title,
        description: String = Self.default.description,
        sections: [[SectionItem]] = Self.default.sections,
        rate: Double = Self.default.rate,
        rateCount: Int = Self.default.rateCount
    ) {
        self.imagePath = imagePath
        self.title = title
        self.description = description
        self.sections = sections
        self.rate = rate
        self.rateCount = rateCount
    }
}

extension ItemDetailsViewModel {
    public static var `default`: ItemDetailsViewModel = .init(
        imagePath: "",
        title: "",
        description: "",
        sections: [],
        rate: 0,
        rateCount: 0
    )
}
