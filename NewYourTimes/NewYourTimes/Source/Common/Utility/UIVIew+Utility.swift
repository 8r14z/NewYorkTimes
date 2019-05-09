//
//  NSLayoutAnchor+Utility.swift
//  NewYourTimes
//
//  Created by An Le  on 5/8/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



enum LayoutAttribute {
    case top
    case left
    case bottom
    case right
    case leading
    case trailing
}



extension UIView {
    
    @discardableResult
    func constraintCenter(to view: UIView) -> Self {
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return self
    }
    
    @discardableResult
    func constraint(_ attribute: LayoutAttribute,
                    to view: UIView,
                    constant: CGFloat = 0) -> Self {
        
        switch attribute {
        case .top:
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
            break
            
        case .left:
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: constant).isActive = true
            break
            
        case .right:
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: constant).isActive = true
            break
            
        case .bottom:
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: constant).isActive = true
            break
            
        case .leading:
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant).isActive = true
            break
            
        case .trailing:
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constant).isActive = true
            break

        }
        
        return self
    }
    
    @discardableResult
    func constraintEqual(to view: UIView) -> Self {
        return constraint(.top, to: view)
            .constraint(.leading, to: view)
            .constraint(.trailing, to: view)
            .constraint(.bottom, to: view)
    }
}
