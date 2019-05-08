//
//  HomeViewController.swift
//  NewYourTimes
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class HomeViewController: UICollectionViewController {
    
    lazy var acvAdapter: ACVAdapter = {
        return ACVAdapter()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        let flowLayout = ACVFlowLayout()
            .autoSizing(true)
            .minimumLineSpacing(0)
            .sectionInset(top: 0, left: 0, bottom: 10, right: 0)
        
        collectionView.collectionViewLayout = flowLayout
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        acvAdapter.collectionView = collectionView
        acvAdapter.dataSource = self
        acvAdapter.delegate = self
    }
}



extension HomeViewController: ACVAdapterDataSource {
    
    func sectionViewModelsForAdapter(_ adapter: ACVAdapter) -> [SectionViewModel] {
        let homeSecionModel = HomeArticleSection(title: "djnasjkdhjkkjsa jhd jksahkjhjkd ajkshj ahsjkhj hkj sjh jkahkjs khdjk asjhdjk ksahj hds jkhaj khsjk djkasj hdjkashkj dh ak", snippet: "", publishedDate: Date(), imageURL: nil)
        return [homeSecionModel,homeSecionModel,homeSecionModel,homeSecionModel,homeSecionModel,homeSecionModel,homeSecionModel,homeSecionModel,homeSecionModel,homeSecionModel,homeSecionModel,homeSecionModel,homeSecionModel,homeSecionModel,homeSecionModel,homeSecionModel,homeSecionModel,homeSecionModel]
    }
}


extension HomeViewController: ACVAdapterDelegate {
    
    func didSelectItem(_ item: ItemViewModel, atIndexPath indexPath: IndexPath) {
        
    }
    
    func didDeselectItem(_ item: ItemViewModel, atIndexPath indexPath: IndexPath) {
        
    }
    
    func didEndDisplayItem(_ item: ItemViewModel, atIndexPath indexPath: IndexPath) {
        
    }
    
    func willDisplayItem(_ item: ItemViewModel, atIndexPath indexPath: IndexPath) {
        
    }
}
