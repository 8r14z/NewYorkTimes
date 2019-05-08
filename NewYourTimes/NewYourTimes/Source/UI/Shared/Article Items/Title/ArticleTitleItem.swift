//
//  ArticleTitleItem.swift
//  NewYourTimes
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



struct ArticleTitleItem: ItemViewModel {
    
    var viewClass: ItemViewProtocol.Type {
        return ArticleTitleCell.self
    }
    
    var viewNibName: String? {
        return "ArticleTitleCell"
    }
    
    private(set) var title: String
    
    init(title: String) {
        self.title = title
    }
}
