//
//  Article.swift
//  NewYourTimes_Demo
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



struct Article: Codable {
    
    var title: String
    var snippet: String
    var date: String
    var images: [Image]?
    
    enum CodingKeys: String, CodingKey {
        
        case title
        case snippet = "abstract"
        case date = "published_date"
        case images = "multimedia"
    }
}
