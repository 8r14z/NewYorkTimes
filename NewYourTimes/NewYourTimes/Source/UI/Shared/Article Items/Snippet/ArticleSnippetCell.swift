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
    
    static func preferredSizeForItem(_ item: ItemViewModel, containerSize: CGSize) -> CGSize {
        
        if let item = item as? ArticleSnippetItem {
            
            let width = containerSize.width
            let height = item.snippet.height(for: width - 40, font: .snippet)
            return CGSize(width: containerSize.width, height: height + 16)
            
        } else {
            return CGSize.zero
        }
    }
}
