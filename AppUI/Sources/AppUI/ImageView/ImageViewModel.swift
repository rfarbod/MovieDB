//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/13/24.
//

import Foundation

public struct ImageViewModel: ViewModelProtocol {
    public let imagePath: String

    init(
        imagePath: String = Self.default.imagePath
    ) {
        self.imagePath = imagePath
    }
}

extension ImageViewModel {
    public static var `default`: ImageViewModel = .init(imagePath: "")
}
