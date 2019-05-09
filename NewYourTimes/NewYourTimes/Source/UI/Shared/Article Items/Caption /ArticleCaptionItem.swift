//
//  ImageCaptionItem.swift
//  NewYourTimes
//
//  Created by An Le  on 5/9/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



struct ArticleCaptionItem: ItemViewModel {
    
    var viewClass: ItemViewProtocol.Type {
        return ArticleCaptionCell.self
    }
    
    var viewNibName: String? {
        return "ArticleCaptionCell"
    }
    
    private(set) var caption: String
    
    init(caption: String) {
        self.caption = caption
    }
}
