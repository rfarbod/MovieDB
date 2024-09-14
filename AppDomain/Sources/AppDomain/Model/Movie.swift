//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/11/24.
//

import Foundation

public struct MovieResponse: Decodable {
    public let results: [Movie]?
    public let page: Int?
    let totalPages: Int?
    let totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

public struct Movie: Decodable {
    public let id: Int
    public let posterPath: String?
    public let overview: String?
    public let title: String?
    public let voteAverage: Double?
    public let voteCount: Int?
    public let genres: [Genre]?
    public let productionCompanies: [ProductionCompany]?

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        let posterPathString = try values.decodeIfPresent(String.self, forKey: .posterPath) ?? ""
        posterPath = imageBaseUrl + posterPathString
        overview = try values.decodeIfPresent(String.self, forKey: .overview)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        voteCount = try values.decodeIfPresent(Int.self, forKey: .voteCount)
        voteAverage = try values.decodeIfPresent(Double.self, forKey: .voteAverage)
        genres = try values.decodeIfPresent([Genre].self, forKey: .genres)
        productionCompanies = try values.decodeIfPresent([ProductionCompany].self, forKey: .productionCompanies)
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case overview
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case genres = "genres"
        case productionCompanies = "production_companies"
    }
}
