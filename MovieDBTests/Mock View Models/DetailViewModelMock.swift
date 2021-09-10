//
//  DetailViewModelMock.swift
//  MovieDBTests
//
//  Created by German Huerta on 10/09/21.
//

import Foundation
@testable import MovieDB



struct DetailViewModelMock:MovieItemDetailProtocol {
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
        return true
    }
    
    func setIsFavorite(value: Bool) {
        
    }
    
}

extension DetailViewModelMock {
    
    static func createMockDetailModel() -> MovieItemDetailProtocol {
        let result = JSONReader.readeFile(fileName: "MovieDetailApiResponse", FileExtension: "json", bundle: HomeViewControllerTests.self, modelType: MovieDetailModel.self)
        switch result {
        
        case .success(let detailModel):
            let id = detailModel.id ?? 0
            let title = detailModel.title ?? ""
            let overview = detailModel.overview ?? ""
            let voteAverage = detailModel.voteAverage ?? 0.0
            let posterPath = detailModel.posterPath ?? ""
            let releaseDate = detailModel.releaseDate ?? ""
            let popularity = detailModel.popularity ?? 0.0
            let runtime = detailModel.runtime ?? 0
            let youtubeTrailers = createMockTrailerModel()
            
            return DetailViewModelMock(id: id, title: title, overview: overview, voteAverage: voteAverage, posterPath: posterPath, releaseDate: releaseDate, popularity: popularity, runtime: runtime, trailers: youtubeTrailers)
            
        case .failure(let error):
            fatalError(error.localizedDescription)
        }
    }
    
    
    static func createMockTrailerModel() -> [TrailerItemProtocol] {
        let result = JSONReader.readeFile(fileName: "TrailersApiResponse", FileExtension: "json", bundle: HomeViewControllerTests.self, modelType: TrailerVideoModel.self)
        switch result {
        
        case .success(let trailerVideoModel):
            if let trailers = trailerVideoModel.results {
                let youtubeTrailers = trailers.filter { trailer in
                    trailer.site == "YouTube"
                }
                let youtubeTrailerVM = youtubeTrailers.compactMap { (trailer) -> TrailerItemProtocol in
                    let key = trailer.key ?? ""
                    return  YoutubeTrailerViewModel(videoKey:  key)
                }
                return youtubeTrailerVM

            } else {
                fatalError()
            }
            
        case .failure(_):
            fatalError()
        }
    }
}

