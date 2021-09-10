//
//  MovieCollectionViewCell.swift
//  MovieDB
//
//  Created by German Huerta on 08/09/21.
//

import Foundation
import UIKit
class MovieCollectionViewCell: UICollectionViewCell {
    static let CELL_ID = "MovieCollectionViewCellID"
    
    private var viewModel:MovieItemProtocol!
    
    @IBOutlet private weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        self.imageView.image = nil
    }
    
    func config(with vm:MovieItemProtocol) {
        self.viewModel = vm
        imageView.downloadImage(url: self.viewModel.getPosterImage(), placeHolder: UIImage(named: "placeholder"))
    }
}
