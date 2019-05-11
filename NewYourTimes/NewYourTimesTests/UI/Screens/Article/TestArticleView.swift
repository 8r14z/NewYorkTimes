//
//  TestArticleView.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest
@testable import NewYourTimes



class TestArticleView: XCTestCase {
    
    var view: ArticleViewController!
    var presenter: MockArticlePresenter!
    
    override func setUp() {
        super.setUp()
        presenter = MockArticlePresenter()
        view = ArticleViewController()
        view.presenter = presenter
    }
    
    func testViewDidLoad() {
        view.viewDidLoad()
        XCTAssertTrue(presenter.didInitialSetup)
    }
    
    func testUpdateView() {
        
        let article = ArticleDetailSection(title: "", publishedDate: Date(), publisher: "", author: "", snippet: "", image: nil, pageIndex: 0)
        
        XCTAssert(view.viewControllers == nil || view.viewControllers!.isEmpty)
        
        view.updateViewWithArticle(article)
        
        XCTAssert(!view.viewControllers!.isEmpty)
    }

}
