//
//  ArticleDetailSection.swift
//  NewYourTimes
//
//  Created by An Le  on 5/10/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



struct ArticleDetailSection: SectionViewModel {
    
    var itemModels: [ItemViewModel]
    
    var supplementaryItems: [SupplementaryKind : ItemViewModel]?
    
    private(set) var pageIndex: Int
    
    init(title: String,
         publishedDate: Date,
         publisher: String?,
         author: String?,
         snippet: String,
         image: Image?,
         pageIndex: Int) {
     
        self.pageIndex = pageIndex
        
        itemModels = []
        
        itemModels.append(ArticleTitleItem(title: title))
        itemModels.append(ArticlePublishedDateItem(publishedDate: publishedDate))
        
        if let publisher = publisher {
            itemModels.append(AdditionalInfoItem(info: publisher))
        }
        
        if let author = author {
            itemModels.append(AdditionalInfoItem(info: author))
        }
        
        itemModels.append(ArticleSnippetItem(snippet: snippet))
        
        if let image = image {
            itemModels.append(ArticleBannerItem(image: image))
            itemModels.append(ArticleCaptionItem(caption: image.caption))
        }
    }
}
