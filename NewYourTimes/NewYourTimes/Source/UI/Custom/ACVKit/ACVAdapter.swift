//
//  ACVAdapter.swift
//  NewYourTimes
//
//  Created by An Le  on 5/8/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



final class ACVAdapter: NSObject {
    
    // MARK: Public Properties
    weak var collectionView: UICollectionView? {
        didSet {
            collectionView?.dataSource = self
            collectionView?.delegate = self
            performUpdate()
        }
    }
    
    weak var dataSource: ACVAdapterDataSource? {
        didSet {
            performUpdate()
        }
    }
    
    weak var delegate: ACVAdapterDelegate?
    
    private(set) var sectionViewModels: [SectionViewModel] = []
    
    
    // MARK: Private Properties
    private var registeredCellClasses = Set<String>()
    private var registeredNibNames = Set<String>()
    private var registeredSupplementaryViewClasses = Set<String>()
    private var registeredSupplementaryViewNibNames = Set<String>()
    
    private func _itemForIndexPath(_ indexPath: IndexPath) -> ItemViewModel {
        return sectionViewModels[indexPath.section].itemModels[indexPath.item]
    }

    func performUpdate() {
        
        // TODO: IN DEVELOPMENT...
        
        guard let dataSource = dataSource else {
            return
        }
        
        let oldSectionModels = sectionViewModels
        let newSectionModels = dataSource.sectionViewModelsForAdapter(self)
        
        sectionViewModels = newSectionModels
        
        if oldSectionModels.isEmpty {
            collectionView?.reloadData()
            
        } else {
            
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                
                let oldSectionSet = Set(oldSectionModels.map { $0.identifier() })
                let newSectionSet = Set(newSectionModels.map { $0.identifier() })
                
                let addedSections = newSectionModels
                    .enumerated()
                    .filter { !oldSectionSet.contains($0.element.identifier()) }
                    .map { $0.offset }
                
                let removedSections = oldSectionModels
                    .enumerated()
                    .filter { !newSectionSet.contains($0.element.identifier()) }
                    .map { $0.offset }
                
                // Should apply DIFF to get better time complexity
                var movedSections = [(from: Int, to: Int)]()
                for (fromIndex, oldSection) in oldSectionModels.enumerated() {
                    if newSectionSet.contains(oldSection.identifier()) {
                        if let toIndex = newSectionModels.firstIndex(where: {oldSection.identifier() == $0.identifier() }) {
                            if fromIndex != toIndex {
                                movedSections.append((from: fromIndex, to: toIndex))
                            }
                        }
                    }
                }
                
                if !addedSections.isEmpty || !removedSections.isEmpty || !movedSections.isEmpty {
                    
                    DispatchQueue.main.async { [weak self] in
                        
                        self?.collectionView?.performBatchUpdates({
                            
                            movedSections.forEach { self?.collectionView?.moveSection($0.from, toSection: $0.to) }
                            self?.collectionView?.deleteSections(IndexSet(removedSections))
                            self?.collectionView?.insertSections(IndexSet(addedSections))
                            
                        }, completion: nil)
                    }
                }
            }
        }
    }

}



extension ACVAdapter: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionViewModels[section].itemModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let itemModel = _itemForIndexPath(indexPath)
        var cell: UICollectionViewCell
        
        if let nibName = itemModel.viewNibName {

            if !registeredNibNames.contains(nibName) {
                registeredNibNames.insert(nibName)
                
                let nib = UINib(nibName: nibName, bundle: nil)
                collectionView.register(nib, forCellWithReuseIdentifier: nibName)
            }
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: nibName, for: indexPath)
            
        } else {
            
            let className = String.init(describing: itemModel.viewClass)

            if !registeredCellClasses.contains(className) {
                registeredCellClasses.insert(className)
                
                collectionView.register(itemModel.viewClass, forCellWithReuseIdentifier: className)
            }
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: className, for: indexPath)
        }
        
        if let cell = cell as? ItemViewProtocol {
            
            if self is ItemViewDelegate {
                cell.itemViewDelegate = self as? ItemViewDelegate
            }
            
            cell.didUpdate(itemModel)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let supplementaryItemModel = sectionViewModels[indexPath.section].supplementaryItems?[kind] else {
            fatalError()
        }
        
        var view: UICollectionReusableView
        
        if let nibName = supplementaryItemModel.viewNibName {
            
            if !registeredSupplementaryViewNibNames.contains(nibName) {
                registeredSupplementaryViewNibNames.insert(nibName)
                
                let nib = UINib(nibName: nibName, bundle: nil)
                collectionView.register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: nibName)
            }
            
            view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: nibName, for: indexPath)
            
        } else {
            
            let className = String.init(describing: supplementaryItemModel.viewClass)
            
            if !registeredSupplementaryViewClasses.contains(className) {
                registeredSupplementaryViewClasses.insert(className)
                
                collectionView.register(supplementaryItemModel.viewClass, forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
            }
            
            view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: className, for: indexPath)
        }
        
        if let view = view as? ItemViewProtocol {
            
            if self is ItemViewDelegate {
                view.itemViewDelegate = self as? ItemViewDelegate
            }
            
            view.didUpdate(supplementaryItemModel)
        }
        
        return view
    }
}


extension ACVAdapter: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem(_itemForIndexPath(indexPath), atIndexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        delegate?.didDeselectItem(_itemForIndexPath(indexPath), atIndexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard collectionView.isScrolling() else {
            return
        }
        
        if indexPath.row == 0 {
            delegate?.willDisplaySection(section: indexPath.section)
        }
        
        guard let cell = cell as? ItemViewProtocol else {
            fatalError("Cell must conform to ItemViewProtocol")
        }
        
        if let item = cell.itemModel {
            delegate?.willDisplayItem(item, atIndexPath: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard collectionView.isScrolling() else {
            return
        }
        
        if indexPath.row == sectionViewModels[indexPath.section].itemModels.count - 1 {
            delegate?.didEndDisplaySection(section: indexPath.section)
        }
        
        guard let cell = cell as? ItemViewProtocol else {
            fatalError("Cell must conform to ItemViewProtocol")
        }
        
        if let item = cell.itemModel {
            delegate?.didEndDisplayItem(item, atIndexPath: indexPath)
        }
    }
    
}


extension ACVAdapter: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemModel = _itemForIndexPath(indexPath)
        let ViewClass = itemModel.viewClass
        return ViewClass.preferredSizeForItem(itemModel, containerSize: collectionView.bounds.size)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        guard let supplementaryItemModel = sectionViewModels[section].supplementaryItems?[UICollectionView.elementKindSectionFooter] else {
            return CGSize.zero
        }
        
        let ViewClass = supplementaryItemModel.viewClass
        return ViewClass.preferredSizeForItem(supplementaryItemModel, containerSize: collectionView.bounds.size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        guard let supplementaryItemModel = sectionViewModels[section].supplementaryItems?[UICollectionView.elementKindSectionHeader] else {
            return CGSize.zero
        }
        
        let ViewClass = supplementaryItemModel.viewClass
        return ViewClass.preferredSizeForItem(supplementaryItemModel, containerSize: collectionView.bounds.size)
    }
}



// MARK: === Data Source & Delegate ===
protocol ACVAdapterDataSource: AnyObject {
    func sectionViewModelsForAdapter(_ adapter: ACVAdapter) -> [SectionViewModel]
}

protocol ACVAdapterDelegate: AnyObject {
    func didSelectItem(_ item: ItemViewModel, atIndexPath indexPath: IndexPath)
    func didDeselectItem(_ item: ItemViewModel, atIndexPath indexPath: IndexPath)
    func didEndDisplayItem(_ item: ItemViewModel, atIndexPath indexPath: IndexPath)
    func willDisplayItem(_ item: ItemViewModel, atIndexPath indexPath: IndexPath)
    func willDisplaySection(section: Int)
    func didEndDisplaySection(section: Int)
}

extension ACVAdapterDelegate {
    func didSelectItem(_ item: ItemViewModel, atIndexPath indexPath: IndexPath) { }
    func didDeselectItem(_ item: ItemViewModel, atIndexPath indexPath: IndexPath) { }
    func didEndDisplayItem(_ item: ItemViewModel, atIndexPath indexPath: IndexPath) { }
    func willDisplayItem(_ item: ItemViewModel, atIndexPath indexPath: IndexPath) { }
    func willDisplaySection(section: Int) { }
    func didEndDisplaySection(section: Int) { }
}

