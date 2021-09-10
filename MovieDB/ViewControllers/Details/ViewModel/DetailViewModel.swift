//
//  DetailViewModel.swift
//  MovieDB
//
//  Created by German Huerta on 09/09/21.
//

import Foundation
struct DetailViewModel:MovieItemDetailProtocol {
    private var title:String
    private var overview:String
    private var voteAverage:Double
    private var posterPath:String
    private var releaseDate: String
    private var popularity: Double
    private var runtime:Int
    private var trailers:[TrailerItemProtocol]
    private var id:Int
    
    init(id:Int, title:String, overview:String, voteAverage:Double, posterPath:String, releaseDate:String, popularity:Double, runtime:Int, trailers:[TrailerItemProtocol]) {
        self.id = id
        self.title = title
        self.overview = overview
        self.voteAverage = voteAverage
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.popularity = popularity
        self.runtime = runtime
        self.trailers = trailers
    }
    
    func getTitle() -> String {
        return title
    }
    
    func getOverview() -> String {
        return overview
    }
    
    func getVoteAverage() -> String {
        return "\(self.voteAverage) / 10"
    }
    
    func getPosterPath() -> String {
        let fullPath = Constants.BASE_IMAGE_URL + ImageSize.w154.rawValue  + self.posterPath

        return fullPath
    }
    
    func getReleaseDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from:self.releaseDate)!
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: date)
        if let year = components.year {
            return String(year)
        }
        
        return self.releaseDate
    }
    
    func getPopularity() -> String {
        return "Popularity: \(self.popularity)%"
    }
    
    func getMovieDuration() -> String {
        return "\(self.runtime) min"
    }
    
    func getTrailer(at index:Int) -> TrailerItemProtocol {
        return trailers[index]
    }
    func getTrailerCount() -> Int {
        return trailers.count
    }
    
    func isFavorite() -> Bool {
        let idStr = String(self.id)

        if let favoritesDictionary = UserDefaults.standard.object(forKey: Constants.FAVORITES_DICTIONARY_KEY)
            as? [String: String] {
            if let result = favoritesDictionary[idStr] {
                if result == "true" {
                    return true

                }
            }
        } else {
            let favoritesDictionary:[String:String] = [idStr : "false"]
            UserDefaults.standard.setValue(favoritesDictionary, forKey: Constants.FAVORITES_DICTIONARY_KEY)
            UserDefaults.standard.synchronize()
        }
        return false
    }
    
    func setIsFavorite(value:Bool) {
        let idStr = String(self.id)
        let valueStr = String(value)
        if let favoritesDictionary = UserDefaults.standard.object(forKey: Constants.FAVORITES_DICTIONARY_KEY)
            as? [String: String] {
            var dictionary = favoritesDictionary
            dictionary[idStr] = valueStr
            UserDefaults.standard.setValue(dictionary, forKey: Constants.FAVORITES_DICTIONARY_KEY)
        } else {
            let favoritesDictionary:[String:String] = [idStr : valueStr]
            UserDefaults.standard.setValue(favoritesDictionary, forKey: Constants.FAVORITES_DICTIONARY_KEY)
        }
        UserDefaults.standard.synchronize()

    }
}
