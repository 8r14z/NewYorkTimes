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
    func identifier() -> Identifier
}



protocol ItemViewProtocol: AnyObject {
    
    var itemModel: ItemViewModel? { get set }

    var itemViewDelegate: ItemViewDelegate? { get set }
    
    func didUpdate(_ object: ItemViewModel)
    
    /// Calculate preferred size for item using in collection view. By default its size is (containerSize.width, 100)
    static func preferredSizeForItem(_ item: ItemViewModel, containerSize: CGSize) -> CGSize
}


extension ItemViewProtocol {
    
    static func preferredSizeForItem(_ item: ItemViewModel, containerSize: CGSize) -> CGSize {
        return CGSize(width: containerSize.width, height: 100)
    }
}



protocol ItemViewModel {
    
    var viewClass: ItemViewProtocol.Type { get }
    var viewNibName: String? { get }
}



protocol SectionViewModel: Identifiable {
    
    var itemModels: [ItemViewModel] { get set }
    
    var supplementaryItems: [SupplementaryKind: ItemViewModel]? { get set }
}
