//
//  SearchKeywordSection.swift
//  NewYourTimes
//
//  Created by An Le  on 5/9/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



struct SearchKeywordSection: SectionViewModel {
    
    var itemModels: [ItemViewModel]
    
    var supplementaryItems: [SupplementaryKind : ItemViewModel]?

    init(keyword: String) {
        itemModels = [AdditionalInfoItem(info: keyword)]
    }
}
