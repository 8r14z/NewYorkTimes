//
//  UIScrollView+Utility.swift
//  NewYourTimes
//
//  Created by An Le  on 5/8/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



extension UIScrollView {
    
    func isScrolling() -> Bool {
        return self.isDecelerating || self.isDragging || self.isTracking
    }
}
