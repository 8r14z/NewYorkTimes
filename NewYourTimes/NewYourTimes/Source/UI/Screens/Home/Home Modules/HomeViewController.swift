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

        clearsSelectionOnViewWillAppear = false
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: collectionView.bounds.width, height: 100)
        }
        
        acvAdapter.collectionView = collectionView
        acvAdapter.dataSource = self
        acvAdapter.delegate = self
    }
}



extension HomeViewController: ACVAdapterDataSource {
    
    func sectionViewModelsForAdapter(_ adapter: ACVAdapter) -> [SectionViewModel] {
        let homeSecionModel = HomeArticleSection(title: "dasdas", snippet: "", publishedDate: Date(), imageURL: nil)
        return [homeSecionModel,homeSecionModel,homeSecionModel,homeSecionModel,homeSecionModel,homeSecionModel,homeSecionModel,homeSecionModel,homeSecionModel]
    }
}


extension HomeViewController: ACVAdapterDelegate {
    
    func didSelectItem(_ item: ItemViewModel, atIndexPath indexPath: IndexPath) {
        
    }
    
    func didDeselectItem(_ item: ItemViewModel, atIndexPath indexPath: IndexPath) {
        
    }
}
