//
//  Box.swift
//  MovieDB
//
//  Created by German Huerta on 08/09/21.
//

import Foundation
final class Box<T> {

  typealias Listener = (T) -> Void
  var listener: Listener?

  var value: T {
    didSet {
      listener?(value)
    }
  }
    
  init(_ value: T) {
    self.value = value
  }

  func bind(listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
}
