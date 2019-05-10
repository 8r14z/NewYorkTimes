//
//  Image.swift
//  NewYourTimes
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



enum ImageFormat: String, Codable {
    case standardThumbnail = "Standard Thumbnail"
    case normal = "Normal"
    case mediumThreeByTwo210 = "mediumThreeByTwo210"
    case mediumThreeByTwo440 = "mediumThreeByTwo440"
    case unknown = "unknown"
}



struct Image: Codable {
    var url: String
    var format: ImageFormat
    var caption: String
    var width: Int
    var height: Int
}
