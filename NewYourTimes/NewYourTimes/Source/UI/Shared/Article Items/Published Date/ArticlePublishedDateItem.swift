//
//  ArticlePublishedDateItem.swift
//  NewYourTimes
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



struct ArticlePublishedDateItem: ItemViewModel {
    
    var viewClass: ItemViewProtocol.Type {
        return ArticlePublishedDateCell.self
    }
    
    var viewNibName: String? {
        return "ArticlePublishedDateCell"
    }
    
    private(set) var publishedDate: Date
    
    init(publishedDate: Date) {
        self.publishedDate = publishedDate
    }
}
