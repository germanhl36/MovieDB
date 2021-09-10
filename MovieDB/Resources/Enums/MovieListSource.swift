//
//  MovieListSource.swift
//  MovieDB
//
//  Created by German Huerta on 08/09/21.
//

import Foundation
enum MovieListSource:String {
    case topRated = "https://api.themoviedb.org/3/movie/top_rated"
    case mostPopular = "https://api.themoviedb.org/3/movie/popular"
}
