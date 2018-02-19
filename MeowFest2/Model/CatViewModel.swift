//
//  CatViewModel.swift
//  MeowFest2
//
//  Created by May Yang on 2/18/18.
//  Copyright © 2018 May Yang. All rights reserved.
//

import Foundation

struct CatViewModel {
    let title: String?
    let timestamp: String?
    let image_url: String?
    let description: String?
    
    init(cat: Cat) {
        title = cat.title
        timestamp = cat.timestamp
        image_url = cat.image_url
        description = cat.description
    }
}
