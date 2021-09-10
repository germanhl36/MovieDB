//
//  CollectionProtocol.swift
//  MovieDB
//
//  Created by German Huerta on 08/09/21.
//

import Foundation
protocol CollectionProtocol {
    func getItems(from source:MovieListSource, page:Int)
    func reloadDataIfNeeded(action:@escaping ()->())
    func getCount() -> Int
    func getItemVM(at index:Int) -> MovieItemProtocol
    mutating func errorHandler(onError: @escaping (Error) -> Void)
    mutating func selectionHandler(onItemSelected: @escaping (MovieItemDetailProtocol) -> Void)
    func itemSelected(atIndex index:Int)
}
