//
//  HomeViewModel.swift
//  MovieDB
//
//  Created by German Huerta on 08/09/21.
//

import Foundation

struct HomeViewModel: CollectionProtocol {
    private var items:Box<[MovieItemProtocol]> = Box<[MovieItemProtocol]>([])
    private var errorHandler:((Error) -> ())?
    private var headerImage:String!
    private var selectionHandler:((MovieItemDetailProtocol) ->())?
    private var movieAPI = MovieDBAPI()
    
    func convertMovies(moviesFromAPI:[MovieModel]) -> [MovieItemProtocol] {
        let results:[MovieItemProtocol] = moviesFromAPI.compactMap { (movie:MovieModel) -> (MovieCollectionCellViewModel) in
            return MovieCollectionCellViewModel(movieID: movie.id, posterImagePath: movie.posterPath)
        }
        return results
    }
    
    func getItems(from source:MovieListSource, page:Int) {
        movieAPI.getMovieList(from: source, page: page) { movies in
            if page == 1 {
                items.value = self.convertMovies(moviesFromAPI: movies)
            } else {
                items.value.append( contentsOf: self.convertMovies(moviesFromAPI: movies))
            }
        } error: { error in
            self.errorHandler?(error)
        }
    }
    
    func reloadDataIfNeeded(action: @escaping () -> ()) {
        self.items.bind {_ in
            action()
        }
    }
    
    func getCount() -> Int {
        return items.value.count
    }
    
    func getItemVM(at index: Int) -> MovieItemProtocol {
        return items.value[index]
    }
    
    mutating func errorHandler(onError: @escaping (Error) -> Void) {
        self.errorHandler = onError
    }
    
    mutating func selectionHandler(onItemSelected: @escaping (MovieItemDetailProtocol) -> Void) {
        self.selectionHandler = onItemSelected
    }
    
    func itemSelected(atIndex index: Int) {
//        self.selectionHandler?(index)
        let vm = self.getItemVM(at: index)
        
        movieAPI.getMovieDetails(id: vm.getID()) { detailModel in
            self.getMovieTrailers(detailModel: detailModel)
        } error: { error in
            self.errorHandler?(error)
        }

    }
    
    
    private func getMovieTrailers(detailModel:MovieDetailModel){
        if let id = detailModel.id {
            movieAPI.getMovieTrailers(id: id) { trailers in
               let detailVM = self.createDetailVM(from: detailModel, trailers: trailers)
                self.selectionHandler?(detailVM)
            } error: { error in
                self.errorHandler?(error)
            }
        } else {
            
        }
        

    }
    
    private func createDetailVM(from detailModel:MovieDetailModel, trailers:[TrailerInfo]) -> MovieItemDetailProtocol {
        let id = detailModel.id ?? 0
        let title = detailModel.title ?? ""
        let overview = detailModel.overview ?? ""
        let voteAverage = detailModel.voteAverage ?? 0.0
        let posterPath = detailModel.posterPath ?? ""
        let releaseDate = detailModel.releaseDate ?? ""
        let popularity = detailModel.popularity ?? 0.0
        let runtime = detailModel.runtime ?? 0
        let youtubeTrailers = trailers.filter { trailer in
            trailer.site == "YouTube"
        }
        let youtubeTrailerVM = youtubeTrailers.compactMap { (trailer) -> TrailerItemProtocol in
            let key = trailer.key ?? ""
            return  YoutubeTrailerViewModel(videoKey:  key)
        }
        
        return DetailViewModel(id: id, title: title, overview: overview, voteAverage: voteAverage, posterPath: posterPath, releaseDate: releaseDate, popularity: popularity, runtime: runtime, trailers: youtubeTrailerVM)
    }
    
}
