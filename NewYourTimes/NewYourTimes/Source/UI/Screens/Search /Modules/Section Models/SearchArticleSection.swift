//
//  SearchArticleSection.swift
//  NewYourTimes
//
//  Created by An Le  on 5/9/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



struct SearchArticleSection: SectionViewModel {
    
    var itemModels: [ItemViewModel]
    
    var supplementaryItems: [SupplementaryKind : ItemViewModel]?
    
    init(title: String, snippet: String, publisher: String) {
        
        itemModels = [
            ArticleTitleItem(title: title),
            ArticleSnippetItem(snippet: snippet),
            AdditionalInfoItem(info: publisher),
            SeparatorItem()
        ]
    }
}
