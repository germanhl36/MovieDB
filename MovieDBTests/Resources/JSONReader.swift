//
//  JSONReader.swift
//  MovieDBTests
//
//  Created by German Huerta on 10/09/21.
//

import Foundation
struct JSONReader {
    static func readeFile<T : Decodable>(fileName:String, FileExtension:String ,bundle:AnyClass, modelType:T.Type) -> (Result<T, Error>) {
        let url = Bundle(for: bundle).url(forResource: fileName, withExtension: FileExtension)
        guard let dataURL = url, let data = try? Data(contentsOf: dataURL) else {
             fatalError("Couldn't read data.json file")
        }
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(modelType, from: data)
            return .success(result)
        }catch (let error) {
            return .failure(error)
        }
    }
}
