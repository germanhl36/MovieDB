//
//  ServiceManager.swift
//  MovieDB
//
//  Created by German Huerta on 08/09/21.
//

import Foundation
final class MovieDBAPI {
    
    enum HTTPError: Error {
        case invalidURL
        case invalidDecoding
        case invalidResponse(Data?, URLResponse?)
    }
    
    public func getMovieList(from source:MovieListSource, page:Int = 1, success:@escaping ([MovieModel]) -> (), error:@escaping (Error) -> ()) {
        var urlComponents = URLComponents(string: source.rawValue)
        let apiKeyItem = URLQueryItem(name: "api_key", value: Constants.MOVIEDB_API_KEY)
        let languageItem = URLQueryItem(name: "language", value: "en-US")

        var itemsArray = [apiKeyItem, languageItem]
        if page != 0 {
            let pageItem = URLQueryItem(name: "page", value: String(page))
            itemsArray.append(pageItem)
        }
        urlComponents?.queryItems = itemsArray

        if let url  = urlComponents?.url {
            self.request(url: url) { (result:Result<MovieListModel,Error>) in
                switch(result) {
                case .success(let movieListModel):
                    if let results = movieListModel.results
                    {
                        success(results)
                    }
                    
                    break
                case .failure(let e):
                    print(e.localizedDescription)

                    error(e)
                    break
                }
            }
        }
    }
    
    //    Get Movie details
    //    https://api.themoviedb.org/3/movie/238?api_key=c936fd93e894c124f7cef2a4137e6668&language=en-US
     func getMovieDetails(id:Int, success:@escaping (MovieDetailModel) -> (), error:@escaping (Error) -> ()) {
        var urlComponents = URLComponents(string: Constants.BASE_MOVIE_API_URL + "\(id)")
        let apiKeyItem = URLQueryItem(name: "api_key", value: Constants.MOVIEDB_API_KEY)
        let languageItem = URLQueryItem(name: "language", value: "en-US")
        
        let itemsArray = [apiKeyItem, languageItem]
        
        urlComponents?.queryItems = itemsArray
        
        if let url  = urlComponents?.url {
            self.request(url: url) { (result:Result<MovieDetailModel,Error>) in
                switch(result) {
                case .success(let movieDetailModel):
                    
                    success(movieDetailModel)
                    
                    break
                case .failure(let e):
                    print(e.localizedDescription)
                    
                    error(e)
                    break
                }
            }
        }
    }
  
//    https://api.themoviedb.org/3/movie/238/videos?api_key=c936fd93e894c124f7cef2a4137e6668&language=en-US
    func getMovieTrailers(id:Int, success:@escaping ([TrailerInfo]) -> (), error:@escaping (Error) -> ()) {
        var urlComponents = URLComponents(string: Constants.BASE_MOVIE_API_URL + "\(id)/videos")
        let apiKeyItem = URLQueryItem(name: "api_key", value: Constants.MOVIEDB_API_KEY)
        let languageItem = URLQueryItem(name: "language", value: "en-US")
        
        let itemsArray = [apiKeyItem, languageItem]
        
        urlComponents?.queryItems = itemsArray
        
        if let url  = urlComponents?.url {
            self.request(url: url) { (result:Result<TrailerVideoModel,Error>) in
                switch(result) {
                case .success(let trailerVideoModel):
                    if let trailers = trailerVideoModel.results {
                        success(trailers)
                    }
                    
                    break
                case .failure(let e):
                    print(e.localizedDescription)
                    
                    error(e)
                    break
                }
            }
        }
    }
    
    public func request<T: Codable>(url: URL, completionBlock: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completionBlock(.failure(error!))
                return
            }
            
            guard let responseData = data,
            let httpResponse = response as? HTTPURLResponse,
                200 ..< 300 ~= httpResponse.statusCode else {
                    completionBlock(.failure(HTTPError.invalidResponse(data, response)))
                    return
            }
            
            do {
                let str = String(data: responseData, encoding: .utf8)
                print(str as Any)
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: responseData)
                completionBlock(.success(result))
            } catch {
                print(error)
                completionBlock(.failure(HTTPError.invalidDecoding))
            }
        }
        task.resume()
    }
}
