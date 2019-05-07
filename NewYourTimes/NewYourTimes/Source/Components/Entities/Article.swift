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
    var updatedDate: Date
    var publishedDate: Date
    var images: [Image]?
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        
        case title
        case snippet = "abstract"
        case updatedDate = "updated_date"
        case publishedDate = "published_date"
        case images = "multimedia"
    }
}


extension Article {
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        snippet = try values.decode(String.self, forKey: .snippet)
        updatedDate = try values.decode(Date.self, forKey: .updatedDate)
        publishedDate = try values.decode(Date.self, forKey: .publishedDate)
        images = try? values.decode([Image].self, forKey: .images)
    }
}
