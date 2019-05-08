//
//  HomeArticleSnippetCell.swift
//  NewYourTimes
//
//  Created by An Le  on 5/8/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit

class ArticleSnippetCell: UICollectionViewCell, ItemViewProtocol {
    
    @IBOutlet weak var snippetLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var itemModel: ItemViewModel?
    
    var itemViewDelegate: ItemViewDelegate?
    
    func didUpdate(_ object: ItemViewModel) {
        
        if let object = object as? ArticleSnippetItem {
            snippetLabel.text = object.snippet
        }
    }
    
}
