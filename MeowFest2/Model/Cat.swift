//
//  Cat.swift
//  MeowFest2
//
//  Created by May Yang on 2/18/18.
//  Copyright © 2018 May Yang. All rights reserved.
//

import Foundation

struct Cat {
    let title: String?
    let timestamp: String?
    let image_url: String?
    let description: String?
    
    init(title: String, timestamp: String, image_url: String, description: String) {
        self.title = title
        self.timestamp = timestamp
        self.image_url = image_url
        self.description = description
    }
}
