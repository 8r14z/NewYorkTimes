//
//  MockArticleView.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation
@testable import NewYourTimes



class MockArticleView: ArticleViewProtocol {
    
    var presenter: ArticlePresenterProtocol?
    
    var didUpdateView = false
    var article: ArticleDetailSection?
    var didShowError = false
    
    func updateViewWithArticle(_ article: ArticleDetailSection) {
        didUpdateView = true
        self.article = article
    }
    
    func showError(_ error: Error) {
        didShowError = true
    }
    
}
