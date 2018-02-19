//
//  LoadingViewCell.swift
//  MeowFest2
//
//  Created by May Yang on 2/18/18.
//  Copyright © 2018 May Yang. All rights reserved.
//

import Foundation
import UIKit

class LoadingViewCell: UICollectionViewCell {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func configure() {
        activityIndicator.startAnimating()
    }
}
