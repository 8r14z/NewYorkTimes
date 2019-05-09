//
//  ImageCaptionCell.swift
//  NewYourTimes
//
//  Created by An Le  on 5/9/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



class ArticleCaptionCell: UICollectionViewCell, ItemViewProtocol {

    @IBOutlet weak var captionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var itemModel: ItemViewModel?
    
    var itemViewDelegate: ItemViewDelegate?
    
    func didUpdate(_ object: ItemViewModel) {
        
        if let object = object as? ArticleCaptionItem {
            captionLabel.text = object.caption
        }
    }
    
    static func preferredSizeForItem(_ item: ItemViewModel, containerSize: CGSize) -> CGSize {
        
        if let item = item as? ArticleCaptionItem {
            
            let width = containerSize.width
            let height = item.caption.height(for: width - 40, font: .smallBody)
            
            return CGSize(width: containerSize.width, height: height + 16)
            
        } else {
            return CGSize.zero
        }
    }
    
}
