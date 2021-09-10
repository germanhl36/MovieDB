//
//  Constants.swift
//  MovieDB
//
//  Created by German Huerta on 08/09/21.
//

import Foundation
import UIKit

struct Constants {
    static var MOVIEDB_API_KEY:String = {
        if let movieDBKey = Bundle.main.infoDictionary?["MOVIEDB_KEY"] as? String {
            return movieDBKey
        }
        return ""
    }()
    static var BASE_MOVIE_API_URL = "https://api.themoviedb.org/3/movie/"
    static var BASE_IMAGE_URL:String = "http://image.tmdb.org/t/p/"
    static var BASE_YOUTUBE_URL = "https://www.youtube.com/watch?v="
    static var BASE_YOUTUBE_THUMBNAIL_URL = "https://img.youtube.com/vi/"
    static var IMAGE_CACHE = NSCache<NSString, UIImage>()
    static var FAVORITES_DICTIONARY_KEY = "FavoritesDictionary"
    

}
