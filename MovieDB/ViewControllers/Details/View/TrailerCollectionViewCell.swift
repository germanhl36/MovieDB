//
//  TrailerCollectionViewCell.swift
//  MovieDB
//
//  Created by German Huerta on 09/09/21.
//

import Foundation
import UIKit
class TrailerCollectionViewCell: UICollectionViewCell {
    static let CELL_ID = "TrailerCollectionViewCell"
    private var viewModel:TrailerItemProtocol!
    @IBOutlet private weak var imageView: UIImageView!

    func config(with vm:TrailerItemProtocol) {
        self.viewModel = vm
        self.imageView.downloadImage(url: self.viewModel.getThumbnailPath(), placeHolder: UIImage(named: "placeholder"))
    }
}
