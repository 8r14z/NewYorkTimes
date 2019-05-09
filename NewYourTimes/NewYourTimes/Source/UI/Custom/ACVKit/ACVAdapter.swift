//
//  ACVAdapter.swift
//  NewYourTimes
//
//  Created by An Le  on 5/8/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



protocol ACVAdapterProtocol {
    
    /// Update changes on data source: insert, delete, move in batch updates
    func performUpdate()
    func reloadAllSections()
}



final class ACVAdapter: NSObject, ACVAdapterProtocol {
    
    static let sectionHeaderKind = UICollectionView.elementKindSectionHeader
    static let sectionFooterKind = UICollectionView.elementKindSectionFooter
    
    // MARK: === Public Properties ===
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
    
    
    // MARK: === Private Properties ===
    private var sectionViewModels: [SectionViewModel] = []

    
    private var registeredCellClasses = Set<String>()
    private var registeredNibNames = Set<String>()
    private var registeredSupplementaryViewClasses = Set<String>()
    private var registeredSupplementaryViewNibNames = Set<String>()
    
    private func _itemForIndexPath(_ indexPath: IndexPath) -> ItemViewModel {
        return sectionViewModels[indexPath.section].itemModels[indexPath.item]
    }
    
    private func _newSectionModels() -> [SectionViewModel] {
        
        guard let dataSource = dataSource else {
            return []
        }
        
        return dataSource.sectionViewModelsForAdapter(self)
    }

    // MARK: === Perform Actions ===
    func performUpdate() {
        
        guard let dataSource = dataSource else {
            return
        }
        
        let oldSectionModels = sectionViewModels
        
        if oldSectionModels.isEmpty {
            reloadAllSections()
            
        } else {
            
            let newSectionModels = dataSource.sectionViewModelsForAdapter(self)
            sectionViewModels = newSectionModels

            #warning("Apply DIFF to get better performace")
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in

                let oldSectionMap = oldSectionModels.enumerated().reduce(into: [Identifier: (offset: Int, SectionViewModel)](), { $0[$1.element.identifier()] = $1 })
                var newSectionMap = newSectionModels.enumerated().reduce(into: [Identifier: (offset: Int, SectionViewModel)](), { $0[$1.element.identifier()] = $1 })
                
                let addedSections = newSectionModels
                    .enumerated()
                    .filter { oldSectionMap[$0.element.identifier()] == nil }
                    .map { $0.offset }
                
                let removedSections = oldSectionModels
                    .enumerated()
                    .filter { newSectionMap[$0.element.identifier()] == nil }
                    .map { $0.offset }
                
                // Should apply DIFF to get better time complexity
                var movedSections = [(from: Int, to: Int)]()
                
                oldSectionMap.forEach { (entry) in
                    if let toIndex = newSectionMap[entry.key]?.offset {
                        let fromIndex = entry.value.offset
                        if toIndex != fromIndex {
                            movedSections.append((from: fromIndex, to: toIndex))
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

    func reloadAllSections() {
        
        sectionViewModels = _newSectionModels()
        
        collectionView?.reloadData()
        collectionView?.collectionViewLayout.invalidateLayout()
        collectionView?.layoutIfNeeded()
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
        delegate?.didSelectSection(indexPath.section)
        delegate?.didSelectItem(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard collectionView.isScrolling() else {
            return
        }
        
        if indexPath.row == 0 {
            delegate?.willDisplaySection(section: indexPath.section)
        }
        
        delegate?.willDisplayItem(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard collectionView.isScrolling() else {
            return
        }
        
        if indexPath.row == sectionViewModels[indexPath.section].itemModels.count - 1 {
            delegate?.didEndDisplaySection(section: indexPath.section)
        }
        
        delegate?.didEndDisplayItem(at: indexPath)
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
    func didSelectItem(at indexPath: IndexPath)
    func didSelectSection(_ section: Int)
    func willDisplayItem(at indexPath: IndexPath)
    func didEndDisplayItem(at indexPath: IndexPath)
    func willDisplaySection(section: Int)
    func didEndDisplaySection(section: Int)
}

extension ACVAdapterDelegate {
    func didSelectItem(at indexPath: IndexPath) { }
    func didSelectSection(_ section: Int) { }
    func willDisplayItem(at indexPath: IndexPath) { }
    func didEndDisplayItem(at indexPath: IndexPath) { }
    func willDisplaySection(section: Int) { }
    func didEndDisplaySection(section: Int) { }
}

