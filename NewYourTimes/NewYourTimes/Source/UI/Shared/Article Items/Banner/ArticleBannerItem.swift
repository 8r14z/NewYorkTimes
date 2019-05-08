//
//  ArticleImageItem.swift
//  NewYourTimes
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



struct ArticleBannerItem: ItemViewModel {
    
    var viewClass: ItemViewProtocol.Type {
        return ArticleBannerCell.self
    }
    
    var viewNibName: String? {
        return "ArticleBannerCell"
    }
    
    private(set) var image: Image
    
    init(image: Image) {
        self.image = image
    }
}
