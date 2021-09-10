//
//  ItemDetailProtocol.swift
//  MovieDB
//
//  Created by German Huerta on 08/09/21.
//

import Foundation
protocol MovieItemDetailProtocol {
    func getTitle() -> String
    func getOverview() -> String
    func getVoteAverage() -> String
    func getPosterPath() -> String
    func getReleaseDate() -> String
    func getPopularity() -> String
    func getMovieDuration() -> String
    func getTrailer(at index:Int) -> TrailerItemProtocol
    func getTrailerCount() -> Int
    func isFavorite() -> Bool
    func setIsFavorite(value:Bool)
}
