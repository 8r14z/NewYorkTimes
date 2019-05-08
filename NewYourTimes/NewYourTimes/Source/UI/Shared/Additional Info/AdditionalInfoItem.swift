//
//  SubInfoItem.swift
//  NewYourTimes
//
//  Created by An Le  on 5/9/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



struct AdditionalInfoItem: ItemViewModel {
    
    var viewClass: ItemViewProtocol.Type {
        return AdditionalInfoCell.self
    }
    
    var viewNibName: String? {
        return "AdditionalInfoCell"
    }
    
    private(set) var info: String
    
    init(info: String) {
        self.info = info
    }
}
