//
//  ViewController.swift
//  MovieDB
//
//  Created by German Huerta on 08/09/21.
//

import UIKit

class HomeViewController:BaseViewController {
    private var viewModel:CollectionProtocol!
    private var selectedSource:MovieListSource = .mostPopular
    private var actionButton: ActionButton!
    private var waiting:Bool = false
    private var currentPage = 1
    private let sectionInsets = UIEdgeInsets(
        top: 0,
        left: 0,
        bottom: 0,
        right: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Most popular"
        self.navigationItem.largeTitleDisplayMode = .always
        self.collectionView.contentInsetAdjustmentBehavior = .always

        
        self.setUpActionButton()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.largeTitleDisplayMode = .always
    }
}

extension HomeViewController {
    func setUpActionButton() {
        let popularImage = UIImage(named: "popularIcon")!
        let ratedImage = UIImage(named: "ratedIcon")!
        
        let pupularActionButttonItem = ActionButtonItem(title: "Most popular", image: popularImage)
        pupularActionButttonItem.action = { item in
            self.actionButton.toggleMenu()
            self.title = "Most popular"
            self.currentPage = 1
            self.showLoadingIndicator()
            self.viewModel.getItems(from: .mostPopular, page: self.currentPage)
        }
        
        
        let ratedActionButtonItem = ActionButtonItem(title: "Top rated", image: ratedImage)
        ratedActionButtonItem.action = { item in
            self.actionButton.toggleMenu()
            self.title = "Top rated"
            self.currentPage = 1
            self.showLoadingIndicator()
            self.viewModel.getItems(from: .topRated , page: self.currentPage)
        }
        
        self.actionButton = ActionButton(attachedToView: self.view, items: [pupularActionButttonItem, ratedActionButtonItem])
        actionButton.action = { button in button.toggleMenu() }
        actionButton.setTitle("+", forState: UIControl.State())
        
        actionButton.backgroundColor = UIColor(red: 238.0/255.0, green: 130.0/255.0, blue: 34.0/255.0, alpha:1.0)
    }
}

// MARK: - Config
extension HomeViewController {
    func config(withVM vm:CollectionProtocol ) {
        self.viewModel = vm
        self.configBindings()
        self.viewModel.getItems(from: selectedSource, page: currentPage)
        
    }
    
    private func configBindings() {
        self.viewModel.reloadDataIfNeeded { [weak self] in
            DispatchQueue.main.async {
                self?.waiting = false
                self?.collectionView.reloadData()
                self?.hideLoadingIndicator()
            }
        }
        
        self.viewModel.errorHandler { [weak self] error in
            DispatchQueue.main.async {
                self?.hideLoadingIndicator()
                self?.showErrorDialog(error: error)
            }
        }
        
        self.viewModel.selectionHandler {[weak self]  detailVM in
            DispatchQueue.main.async {
                self?.selectedItem(vm: detailVM)
            }
        }
    }
}

extension HomeViewController  {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getCount()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.CELL_ID, for: indexPath) as? MovieCollectionViewCell else {
            fatalError()
        }
        let cellVM = self.viewModel.getItemVM(at: indexPath.row)
        cell.config(with: cellVM)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.showLoadingIndicator()
        self.viewModel.itemSelected(atIndex: indexPath.row)
    }
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.viewModel.getCount() - 1 && !self.waiting {
            self.waiting = true
            self.currentPage += 1
            self.viewModel.getItems(from: selectedSource, page: self.currentPage)
        }
    }
    
    
    func selectedItem(vm:MovieItemDetailProtocol) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)

                guard let detailVC = self.storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else {
                    return
                }
        detailVC.config(with: vm)
        self.hideLoadingIndicator()
        showDetailViewController(detailVC, sender: self)
    }
}

extension HomeViewController:UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let imageWidth = 135
        let imageHeight = 185
        return CGSize(width: imageWidth, height: imageHeight)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 1
    }
}

