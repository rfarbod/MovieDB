//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/14/24.
//

import Foundation

public struct SectionItem {
    public let id: Int
    public let title: String
    public let imagePath: String

    public init(id: Int, title: String, imagePath: String) {
        self.id = id
        self.title = title
        self.imagePath = imagePath
    }
}
