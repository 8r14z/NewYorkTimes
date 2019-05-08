//
//  ArticleTitleCell.swift
//  NewYourTimes
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



class ArticleTitleCell: FullWidthCollectionViewCell, ItemViewProtocol {
    
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var itemModel: ItemViewModel?
    
    var itemViewDelegate: ItemViewDelegate?
    
    func didUpdate(_ object: ItemViewModel) {
        
        if let object = object as? ArticleTitleItem {
            titleLabel.text = object.title
        }
    }
    
    static func preferredSizeForItem(_ item: ItemViewModel, containerSize: CGSize) -> CGSize {
        
        if let item = item as? ArticleTitleItem {
            
            let width = containerSize.width
            let height = item.title.height(for: width - 40, font: .title)
            return CGSize(width: containerSize.width, height: height + 16)
            
        } else {
            return CGSize.zero
        }
    }
}
