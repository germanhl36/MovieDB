//
//  DetailViewController.swift
//  MovieDB
//
//  Created by German Huerta on 09/09/21.
//

import Foundation
import UIKit
class DetailViewController: UIViewController {
    private var viewModel:MovieItemDetailProtocol!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var trailerCollectionView: UICollectionView!
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var scrollViewContentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    private let sectionInsets = UIEdgeInsets(
      top: 0,
      left: 0,
      bottom: 0,
      right: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie info"
        self.updateUIContent()
    }
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        let newStatus = !self.viewModel.isFavorite()
        self.viewModel.setIsFavorite(value: newStatus)
        self.updateIsFavorite(value: newStatus)
    }
}


extension DetailViewController {
    func config(with vm:MovieItemDetailProtocol) {
        self.viewModel = vm
    }
    
    func updateUIContent() {
        self.titleLabel.text = self.viewModel.getTitle()
        self.releaseDate.text = self.viewModel.getReleaseDate()
        self.durationLabel.text = self.viewModel.getMovieDuration()
        self.voteAverageLabel.text = self.viewModel.getVoteAverage()
        self.overviewLabel.text = self.viewModel.getOverview()
        self.posterImageView.downloadImage(url: self.viewModel.getPosterPath(), placeHolder: UIImage(named: "placeholder"))
        self.trailerCollectionView.reloadData()
        self.updateIsFavorite(value: self.viewModel.isFavorite())
        scrollViewContentView.layoutIfNeeded()
        scrollView.layoutIfNeeded()
    }
    
    func updateIsFavorite(value:Bool) {
        if value {
            self.favoriteButton.setImage(UIImage(named: "popularIcon"), for: .normal)
        } else {
            self.favoriteButton.setImage(UIImage(named: "emptyPopularIcon"), for: .normal)
        }
    }
}



extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.getTrailerCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrailerCollectionViewCell.CELL_ID, for: indexPath) as? TrailerCollectionViewCell else {
            fatalError()
        }
        let trailer = self.viewModel.getTrailer(at: indexPath.row)
        cell.config(with: trailer)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let trailer = self.viewModel.getTrailer(at: indexPath.row)
        self.trailerSelected(vm: trailer)
    }
    
    func trailerSelected(vm:TrailerItemProtocol) {
        guard let showTrailerVC = self.storyboard?.instantiateViewController(identifier: "ShowTrailerViewController") as? ShowTrailerViewController else {
            return
        }
        showTrailerVC.config(with: vm)
        self.present(showTrailerVC, animated: true, completion: nil)
    }
}


extension DetailViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath:IndexPath
      ) -> CGSize {
       let imageWidth = 240
        let imageHeight = 180
        return CGSize(width: imageWidth, height: imageHeight)
      }
    
     func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout,insetForSectionAt section:Int
     ) -> UIEdgeInsets {
       return sectionInsets
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int
     ) -> CGFloat {
       return 10
     }
}
