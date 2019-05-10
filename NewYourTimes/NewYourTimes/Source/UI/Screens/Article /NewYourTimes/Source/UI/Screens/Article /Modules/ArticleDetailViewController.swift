//
//  ArticleDetailViewController.swift
//  NewYourTimes
//
//  Created by An Le  on 5/9/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



class ArticleDetailViewController: ACVViewController {
    
    private(set) var articleSection: ArticleDetailSection

    init(articleSection: ArticleDetailSection) {
        self.articleSection = articleSection
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        acvAdapter.dataSource = self
    }
}



extension ArticleDetailViewController: ACVAdapterDataSource {
    
    func sectionViewModelsForAdapter(_ adapter: ACVAdapter) -> [SectionViewModel] {
        return [articleSection]
    }
}



