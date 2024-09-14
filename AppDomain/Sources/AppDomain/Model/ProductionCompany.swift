//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/13/24.
//

import Foundation

public struct ProductionCompany: Codable {
    public let id: Int
    public let logoPath: String
    public let name: String

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        let logoPathString = try container.decodeIfPresent(String.self, forKey: .logoPath) ?? ""
        self.logoPath = imageBaseUrl + logoPathString
        self.name = try container.decode(String.self, forKey: .name)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
    }
}
