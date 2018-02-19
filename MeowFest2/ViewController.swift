//
//  ViewController.swift
//  MeowFest2
//
//  Created by May Yang on 1/7/18.
//  Copyright © 2018 May Yang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var imageURLSet = [AnyObject]()
    fileprivate let catViewModelController = CatViewModelController()
    //These two variables will help decide if we should request more data from the server.
    var currentPage = 0
    let totalNumPages = 0
    let totalItems = 0
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Disclaimer: this code is a mess but I had a hard one hour stop, and wasted a good 10 mins fixing weird Xcode 9 simulator/compiler issues.
        catViewModelController.getImages { [weak self] (success, error) in
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
        return catViewModelController.viewModelsCount
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MeowCell", for: indexPath) as? MeowCollectionViewCell
        if let viewModel = catViewModelController.viewModel(at: indexPath.row) {
            cell?.configure(viewModel)
        }
        return cell!
    }

    
}

