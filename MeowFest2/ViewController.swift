//
//  ViewController.swift
//  MeowFest2
//
//  Created by May Yang on 1/7/18.
//  Copyright © 2018 May Yang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    fileprivate let catViewModelController = CatViewModelController()
    //Start at page 0 and increment up
    var currentPage = 0
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAndUpdateImages()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catViewModelController.viewModelsCount + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return indexPath.row == catViewModelController.viewModelsCount ? loadingCellForIndexPath(indexPath: indexPath) : itemCellForIndexPath(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == catViewModelController.viewModelsCount-1 {
            currentPage += 1
            fetchAndUpdateImages()
        }
    }
    
    func itemCellForIndexPath(indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MeowCell", for: indexPath) as? MeowCollectionViewCell,
            let viewModel = catViewModelController.viewModel(at: indexPath.row) {
            cell.configure(viewModel)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func loadingCellForIndexPath(indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoadingCell", for: indexPath) as? LoadingViewCell {
            cell.configure()
            return cell
        }
        return UICollectionViewCell()
    }
    
    func fetchAndUpdateImages() {
        catViewModelController.getImages(currentPage) { (success, error) in
            self.updateCollectionView(success: success, error: error)
        }
    }
    
    func updateCollectionView(success: Bool, error: NSError?) {
        let strongSelf = self
        if !success {
            DispatchQueue.main.async {
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("can't retrieve cats")
                }
            }
        } else {
            DispatchQueue.main.async {
                strongSelf.collectionView.reloadData()
            }
        }
    }
}

