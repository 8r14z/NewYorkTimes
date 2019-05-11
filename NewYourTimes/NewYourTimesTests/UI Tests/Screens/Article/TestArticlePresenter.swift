//
//  TestArticlePresenter.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest
@testable import NewYourTimes



class TestArticlePresenter: XCTestCase {
    
    var presenter: ArticlePresenter!
    var interactor: MockArticleInteractor!
    var view: MockArticleView!
    
    override func setUp() {
        super.setUp()
        
        interactor = MockArticleInteractor()
        view = MockArticleView()
        presenter = ArticlePresenter(currentIndex: 0)
        presenter.view = view
        presenter.interactor = interactor
    }
    
    func testIntialSetup() {
        presenter.initialSetup()
        XCTAssertTrue(interactor.didInitialFetch)
    }
    
    func testWillTransitionToArticle_Next() {
        
        presenter = ArticlePresenter(currentIndex: 0)
        presenter.view = view
        presenter.interactor = interactor
        
        let article = ArticleDetailSection(title: "", publishedDate: Date(), publisher: "", author: "", snippet: "", image: nil, pageIndex: 1)

        presenter.willTransitionFromArticle(article)
        
        
        
    }
}
