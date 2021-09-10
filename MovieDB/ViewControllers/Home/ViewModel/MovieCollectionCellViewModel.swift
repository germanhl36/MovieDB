//
//  MovieCollectionCellViewModel.swift
//  MovieDB
//
//  Created by German Huerta on 08/09/21.
//

import Foundation
struct MovieCollectionCellViewModel:MovieItemProtocol {
    private var movieID:Int!
    private var posterImagePath:String
    
    init(movieID:Int, posterImagePath:String) {
        self.movieID = movieID
        self.posterImagePath = posterImagePath
    }
    
    func getID() -> Int {
        return self.movieID
    }
    
    func getPosterImage() -> String {
        let fullPath = Constants.BASE_IMAGE_URL + ImageSize.w154.rawValue  + self.posterImagePath
        return fullPath
    }
}
