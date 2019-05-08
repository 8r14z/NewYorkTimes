//
//  ArticleSnippetItem.swift
//  NewYourTimes
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



struct ArticleSnippetItem: ItemViewModel {
    
    var viewClass: ItemViewProtocol.Type {
        return ArticleSnippetCell.self
    }
    
    var viewNibName: String? {
        return "ArticleSnippetCell"
    }
    
    private(set) var snippet: String
    
    init(snippet: String) {
        self.snippet = snippet
    }
}
