//
//  HomeViewModelMock.swift
//  MovieDBTests
//
//  Created by German Huerta on 09/09/21.
//

import Foundation
@testable import MovieDB

struct HomeViewModelMock: CollectionProtocol {
    private var items:Box<[MovieItemProtocol]> = Box<[MovieItemProtocol]>([])
    private var errorHandler:((Error) -> ())?
    private var headerImage:String!
    private var selectionHandler:((MovieItemDetailProtocol) ->())?
    
    
    func convertMovies(moviesFromAPI:[MovieModel]) -> [MovieItemProtocol] {
        let results:[MovieItemProtocol] = moviesFromAPI.compactMap { (movie:MovieModel) -> (MovieCollectionCellViewModel) in
            return MovieCollectionCellViewModel(movieID: movie.id, posterImagePath: movie.posterPath)
        }
        return results
    }
    
    func getItems(from source: MovieListSource, page: Int) {
        var fileName = "PopularMoviesAPIResponse"
        if source == .topRated {
          fileName = "TopRatedApiResponse"
        }
        
        let result = JSONReader.readeFile(fileName: fileName, FileExtension: "json", bundle: HomeViewControllerTests.self, modelType: MovieListModel.self)
        switch result {
        
        case .success(let movieListModel):
            if let results = movieListModel.results {
                self.items.value = self.convertMovies(moviesFromAPI: results)
            }
        case .failure(let error):
            fatalError(error.localizedDescription)
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
        
    }
}
