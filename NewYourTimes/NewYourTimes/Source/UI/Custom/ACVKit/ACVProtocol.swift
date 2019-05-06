//
//  AdvancedCollectionViewProtocol.swift
//  NewYourTimes
//
//  Created by An Le  on 5/8/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit

/**
 
 ADVANCED COLLECTION VIEW KIT
 
 ... In development ...
 
 */

typealias SupplementaryKind = String
typealias Identifier = String


protocol ItemViewDelegate { }



protocol Identifiable {
    var identifier: Identifier { get set }
}



protocol ItemViewProtocol: AnyObject {
    
    var itemModel: ItemViewModel? { get set }

    var itemViewDelegate: ItemViewDelegate? { get set }
    
    func didUpdate(_ object: ItemViewModel)
}



protocol ItemViewModel {
    
    var viewClass: ItemViewProtocol.Type { get }
    var viewNibName: String? { get }
    
    func sizeForItem(withContainerSize size: CGSize) -> CGSize
}



protocol SectionViewModel: Identifiable {
    
    var itemModels: [ItemViewModel] { get set }
    
    var supplementaryItems: [SupplementaryKind: ItemViewModel]? { get set }
}
