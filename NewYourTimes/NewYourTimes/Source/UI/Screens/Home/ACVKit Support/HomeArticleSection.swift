//
//  HomeArticleSection.swift
//  NewYourTimes
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



struct HomeArticleSection: SectionViewModel {
    
    var itemModels: [ItemViewModel]
    
    var supplementaryItems: [SupplementaryKind : ItemViewModel]?
    
    private var id: String
    
    init(title: String, snippet: String, publishedDate: Date, imageURL: URL?) {
        
        itemModels = [ArticleTitleItem(title: "1 \(title)"),
                      ArticleTitleItem(title: "2 \(title)"),
                      ArticleTitleItem(title: "3 \(title)"),
                      ArticleTitleItem(title: "4 \(title)"),
                      ArticleTitleItem(title: "5 \(title)")]
        
        id = String(title.hashValue)
//        id = String(imageURL.hashValue)
    }
    
    func identifier() -> Identifier {
        return id
    }
}
