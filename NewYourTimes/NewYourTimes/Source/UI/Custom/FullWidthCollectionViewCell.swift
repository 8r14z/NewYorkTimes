//
//  FullWidthCollectionViewCell.swift
//  NewYourTimes
//
//  Created by An Le  on 5/8/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



class FullWidthCollectionViewCell: UICollectionViewCell {
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        setNeedsLayout() // Mark need layout
        layoutIfNeeded() // then layout immediately
        
        var frame = layoutAttributes.frame
        let targetSize = CGSize(width: bounds.width, height: frame.height)
        let size = contentView.systemLayoutSizeFitting(targetSize)
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
}
