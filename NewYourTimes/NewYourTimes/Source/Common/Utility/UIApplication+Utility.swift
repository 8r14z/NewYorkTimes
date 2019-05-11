//
//  UIApplication+Utility.swift
//  NewYourTimes
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



extension UIApplication {
    
    var topViewController: UIViewController? {
        
        guard var topViewController = UIApplication.shared.keyWindow?.rootViewController else {
            return nil
        }
        
        while let viewController = topViewController.presentedViewController {
            
            if let nc = viewController.navigationController, let topVC = nc.topViewController {
                topViewController = topVC
            } else {
                topViewController = viewController
            }
        }
        
        if let navigationController = topViewController.navigationController {
            topViewController = navigationController
        }
        
        return topViewController
    }
}
