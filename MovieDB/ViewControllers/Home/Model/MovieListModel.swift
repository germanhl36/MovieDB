//
//  MovieListModel.swift
//  MovieDB
//
//  Created by German Huerta on 08/09/21.
//

import Foundation
// MARK: - Welcome
struct MovieListModel: Codable {
    var page: Int?
    var results: [MovieModel]?
    var totalPages:Int?
    var totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case results
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct MovieModel: Codable {
    var adult: Bool?
    var backdropPath: String?
    var genreIDS: [Int]?
    var id: Int
    var originalLanguage: String?
    var originalTitle:String?
    var overview: String?
    var popularity: Double?
    var posterPath:String
    var releaseDate:String?
    var title: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case adult
        case overview
        case popularity
        case title
        case video
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
      }
}
