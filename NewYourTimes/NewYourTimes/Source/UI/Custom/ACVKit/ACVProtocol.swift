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

extension Identifiable {
    func identifier() -> Identifier {
        return String(UUID().hashValue)
    }
}



protocol ItemViewProtocol: AnyObject {
    
    var itemModel: ItemViewModel? { get set }

    var itemViewDelegate: ItemViewDelegate? { get set }
    
    func didUpdate(_ object: ItemViewModel)
    
    /// Calculate preferred size for item using in collection view.
    static func preferredSizeForItem(_ item: ItemViewModel, containerSize: CGSize) -> CGSize
}



protocol ItemViewModel {
    
    var viewClass: ItemViewProtocol.Type { get }
    var viewNibName: String? { get }
}



protocol SectionViewModel: Identifiable {
    
    var itemModels: [ItemViewModel] { get set }
    
    var supplementaryItems: [SupplementaryKind: ItemViewModel]? { get set }
}
