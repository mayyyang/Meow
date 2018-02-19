//
//  MeowCollectionViewCell.swift
//  MeowFest2
//
//  Created by May Yang on 1/7/18.
//  Copyright © 2018 May Yang. All rights reserved.
//

import UIKit
class MeowCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var meowImageView: UIImageView!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var meowDescription: UILabel!
    
    func configure(_ catViewModel: CatViewModel) {
        meowImageView.downloadImageFromUrl(catViewModel.image_url!, imageView: meowImageView)
        title.text = catViewModel.title
        timestamp.text = catViewModel.timestamp
        meowDescription.text = catViewModel.description
    }
}
private extension MeowCollectionViewCell {
    static let defaultBackgroundColor = UIColor.groupTableViewBackground
    
    func setOpaqueBackground() {
        alpha = 1.0
        backgroundColor = MeowCollectionViewCell.defaultBackgroundColor
        meowImageView.alpha = 1.0
        meowImageView.backgroundColor = MeowCollectionViewCell.defaultBackgroundColor
    }
}
