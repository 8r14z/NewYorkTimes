//
//  AdditionalInfoCell.swift
//  NewYourTimes
//
//  Created by An Le  on 5/9/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit

class AdditionalInfoCell: UICollectionViewCell, ItemViewProtocol {

    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var itemModel: ItemViewModel?
    
    var itemViewDelegate: ItemViewDelegate?
    
    func didUpdate(_ object: ItemViewModel) {
        
        
    }
    
    static func preferredSizeForItem(_ item: ItemViewModel, containerSize: CGSize) -> CGSize {
        return CGSize(width: containerSize.width, height: 30)
    }
    
}
