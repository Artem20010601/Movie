//
//  TrendingMovies.swift
//  Spotidy
//
//  Created by Artem on 12/09/2023.
//

import Foundation

// MARK: - TrendingMovie
struct TrendingMovie: Codable {
    let page: Int?
    let movie: [Movie]
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page
        case movie = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Movie
struct Movie: Codable {
    let backdropPath, firstAirDate: String?
    let genreIDS: [Int]?
    let id: Int?
    let name: String?
    let originCountry: [String]?
    let originalName, overview: String?
    let popularity: Double?
    let posterPath: String?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case genreIDS = "genre_ids"
        case id, name
        case originCountry = "origin_country"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
