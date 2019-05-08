//
//  ArticlePublishedDateCell.swift
//  NewYourTimes
//
//  Created by An Le  on 5/8/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



class ArticlePublishedDateCell: UICollectionViewCell, ItemViewProtocol {
    
    @IBOutlet weak var publishedDateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var itemModel: ItemViewModel?
    
    var itemViewDelegate: ItemViewDelegate?
    
    func didUpdate(_ object: ItemViewModel) {
        
        if let object = object as? ArticlePublishedDateItem {
            publishedDateLabel.text = object.publishedDate.iso8601DateString
        }
    }
    
}
