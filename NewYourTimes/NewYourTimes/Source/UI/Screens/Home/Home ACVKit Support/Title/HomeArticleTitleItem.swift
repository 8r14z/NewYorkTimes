//
//  HomeArticleTitleItem.swift
//  NewYourTimes
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



struct HomeArticleTitleItem: ItemViewModel {
    
    var viewClass: ItemViewProtocol.Type {
        return HomeArticleTitleCell.self
    }
    
    var viewNibName: String? {
        return "HomeArticleTitleCell"
    }
    
    private(set) var title: String
    init(title: String) {
        self.title = title
    }
}
