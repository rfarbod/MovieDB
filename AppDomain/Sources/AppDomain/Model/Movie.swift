//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/11/24.
//

import Foundation

struct MovieResponse: Decodable {
    let page: Int?
    let results: [Movie]?
    let totalPages: Int?
    let totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Movie: Decodable, Identifiable, Hashable {
    let id: Int
    let posterPath: URL?
    let overview: String?
    let title: String?

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        let posterPathString = try values.decodeIfPresent(String.self, forKey: .posterPath) ?? ""
        posterPath = URL(string: imageBaseUrl + posterPathString)
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case overview
        case title
    }
}
