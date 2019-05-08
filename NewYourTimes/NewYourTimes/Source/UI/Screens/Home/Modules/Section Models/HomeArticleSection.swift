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
    
    init(title: String, snippet: String, publishedDate: Date, image: Image?) {
        
        itemModels = []
        
        if let image = image {
            itemModels.append(ArticleBannerItem(image: image))
        }
        
        itemModels.append(ArticleTitleItem(title: title))
        itemModels.append(ArticleSnippetItem(snippet: snippet))
        itemModels.append(ArticlePublishedDateItem(publishedDate: publishedDate))
        itemModels.append(SeparatorItem())
        
        id = String(title.hashValue + UUID().hashValue)
    }
    
    func identifier() -> Identifier {
        return id
    }
}
