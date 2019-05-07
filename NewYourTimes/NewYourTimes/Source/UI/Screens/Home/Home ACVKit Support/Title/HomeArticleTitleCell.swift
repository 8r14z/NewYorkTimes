//
//  HomeArticleTitleCell.swift
//  NewYourTimes
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



class HomeArticleTitleCell: UICollectionViewCell, ItemViewProtocol {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var itemModel: ItemViewModel?
    
    var itemViewDelegate: ItemViewDelegate?
    
    func didUpdate(_ object: ItemViewModel) {
        
        if let object = object as? HomeArticleTitleItem {
            titleLabel.text = object.title
        }
    }
    
    static func sizeForItem(_ item: ItemViewModel, containerSize: CGSize) -> CGSize {
        return CGSize(width: containerSize.width, height: 100)
    }
}
