//
//  UIFont+Utility.swift
//  NewYourTimes
//
//  Created by An Le  on 5/8/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



extension UIFont {
    
    static var title: UIFont {
        return UIFont.systemFont(ofSize: 21, weight: .medium)
    }
    
    static var snippet: UIFont {
        return UIFont.systemFont(ofSize: 17, weight: .regular)
    }
    
    static var smallBody: UIFont {
        return UIFont.systemFont(ofSize: 13, weight: .light)
    }
}
