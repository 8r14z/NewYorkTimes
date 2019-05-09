//
//  SectionSepartorItem.swift
//  NewYourTimes
//
//  Created by An Le  on 5/8/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



struct SeparatorItem: ItemViewModel {
    
    var viewClass: ItemViewProtocol.Type {
        return SepartorView.self
    }
    
    var viewNibName: String?
}
