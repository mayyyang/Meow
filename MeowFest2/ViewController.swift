//
//  ViewController.swift
//  MeowFest2
//
//  Created by May Yang on 1/7/18.
//  Copyright © 2018 May Yang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    var imageURLSet = [AnyObject]()
    fileprivate let catViewModelController = CatViewModelController()
    //These two variables will help decide if we should request more data from the server.
    var currentPage = 0
    let totalNumPages = 0
    let totalItems = 0
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.prefetchDataSource = self
        currentPage = 0
        catViewModelController.getImages(currentPage) { [weak self] (success, error) in
            guard let strongSelf = self else { return }
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catViewModelController.viewModelsCount + 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == catViewModelController.viewModelsCount {
            return loadingCellForIndexPath(indexPath: indexPath)
        } else {
            return itemCellForIndexPath(indexPath: indexPath)
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == catViewModelController.viewModelsCount-1 {
            currentPage += 1
            catViewModelController.getImages(currentPage) { [weak self] (success, error) in
                guard let strongSelf = self else { return }
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
    }
    func itemCellForIndexPath(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MeowCell", for: indexPath) as? MeowCollectionViewCell
        if let viewModel = catViewModelController.viewModel(at: indexPath.row) {
            cell?.configure(viewModel)
        }
        return cell!
    }
    func loadingCellForIndexPath(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoadingCell", for: indexPath) as? LoadingViewCell
        cell?.configure()
        return cell!
    }
}
extension ViewController {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            // calculate/update/collect some data
            if let updatedData = catViewModelController.viewModel(at: indexPath.row) {
                
            }
        }
    }
}

