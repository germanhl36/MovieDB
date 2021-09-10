//
//  YoutubeTrailerViewModel.swift
//  MovieDB
//
//  Created by German Huerta on 09/09/21.
//

import Foundation

struct YoutubeTrailerViewModel:TrailerItemProtocol {
    private var key:String
    
    
    init(videoKey:String ) {
        self.key = videoKey
    }
    
    func getPath() -> String {
        return Constants.BASE_YOUTUBE_URL + self.key
    }
    
    func getThumbnailPath() -> String {
        let thumbnail = Constants.BASE_YOUTUBE_THUMBNAIL_URL + self.key + "/0.jpg"
        return thumbnail
    }
}
