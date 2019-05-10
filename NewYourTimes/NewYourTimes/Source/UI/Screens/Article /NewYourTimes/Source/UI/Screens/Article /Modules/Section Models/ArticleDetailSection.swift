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
         publisher: String,
         author: String,
         snippet: String,
         image: Image?, pageIndex: Int = 0) {
     
        self.pageIndex = pageIndex
        
        itemModels = [ArticleTitleItem(title: title),
                      ArticlePublishedDateItem(publishedDate: publishedDate),
                      AdditionalInfoItem(info: publisher),
                      AdditionalInfoItem(info: author),
                      ArticleSnippetItem(snippet: snippet)]
        
        if let image = image {
            itemModels.append(ArticleBannerItem(image: image))
            itemModels.append(ArticleCaptionItem(caption: image.caption))
        }
    }
}
