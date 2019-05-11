//
//  SearchArticle.swift
//  NewYourTimes
//
//  Created by An Le  on 5/9/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



struct SearchArticle: Codable {
    
    private struct Headline: Codable {
        var title: String
        
        enum CodingKeys: String, CodingKey, CaseIterable {
            case title = "main"
        }
    }
    
    var publisher: String
    var snippet: String
    var title: String
    private var headline: Headline
    
    init(title: String, snippet: String, publisher: String) {
        self.title = title
        headline = Headline(title: title)
        self.snippet = snippet
        self.publisher = publisher
    }
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case title
        case headline
        case snippet = "abstract"
        case publisher = "source"
    }
}


extension SearchArticle {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        snippet = try values.decode(String.self, forKey: .snippet)
        publisher = try values.decode(String.self, forKey: .publisher)
        headline = try values.decode(Headline.self, forKey: .headline)
        title = headline.title
    }
}
