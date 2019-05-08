//
//  AutoSizingFlowLayout.swift
//  NewYourTimes
//
//  Created by An Le  on 5/8/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



class ACVFlowLayout: UICollectionViewFlowLayout {
    
    convenience init(autoSizing: Bool) {
        self.init()
        
        if autoSizing {
            estimatedItemSize = CGSize(width: 200, height: 100)
        }
    }
    
    func autoSizing(_ auto: Bool) -> Self {
        estimatedItemSize = auto ? CGSize(width: 1.0, height: 1.0) : CGSize.zero
        return self
    }
    
    func minimumLineSpacing(_ spacing: CGFloat) -> Self {
        minimumLineSpacing = spacing
        return self
    }
    
    func minimumInteritemSpacing(_ spacing: CGFloat) -> Self {
        minimumInteritemSpacing = spacing
        return self
    }
    
    func sectionInset(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> Self {
        sectionInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    @available(iOS 9.0, *)
    func pinSectionHeader(_ pinned: Bool) -> Self {
        sectionHeadersPinToVisibleBounds = pinned
        return self
    }

    @available(iOS 9.0, *)
    func pinSectionFooter(_ pinned: Bool) -> Self {
        sectionFootersPinToVisibleBounds = pinned
        return self
    }
}
