//
//  UIViewController+Utility.swift
//  NewYourTimes
//
//  Created by An Le  on 5/8/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



extension UIViewController {
    
    @objc class func storyboardName() -> String {
        return String(describing: self)
    }
    
    @objc class func storyboardIdentifier() -> String {
        return String(describing: self)
    }
    
    class func viewControllerFromStoryBoard() -> UIViewController? {
        
        let id = storyboardIdentifier()
        let name = storyboardName()
        
        if let viewController = UIStoryboard.loadViewController(with: id, storyboardName: name) {
            return viewController
        } else {
            return UIStoryboard.loadViewController(storyboardName: name)
        }
    }
}
