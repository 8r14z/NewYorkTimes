//
//  TestArticleInteractor.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest
@testable import NewYourTimes



class TestArticleInteractor: XCTestCase {
    
    var interactor: ArticleInteractor!
    var presenter: MockArticlePresenter!
    var queue = DispatchQueue(label: "TestArticleInteractorQueue")
    
    override func setUp() {
        super.setUp()
        
        presenter = MockArticlePresenter()
        interactor = ArticleInteractor()
        interactor.presenter = presenter
        interactor.requestQueue = queue
    }
    
    func testIntialFetchArticle() {
        
        let repository = MockArticleRepository(response: .hit)
        interactor.repository = repository
        
        interactor.intialFetchArticle(at: 0)
        
        queue.sync { }

        XCTAssertTrue(presenter.didFetchFirstArticleSucess)
        XCTAssertNotNil(presenter.currentArticle)
    }
    
    func testIntialFetchArticleEmpty() {
        
        let repository = MockArticleRepository(response: .miss)
        interactor.repository = repository
        
        interactor.intialFetchArticle(at: 0)
        
        queue.sync { }
  
        XCTAssertTrue(presenter.didFetchFirstArticleError)
        XCTAssertNil(presenter.currentArticle)
    }
    
    func testIntialFetchArticleError() {
        
        let repository = MockArticleRepository(response: .error)
        interactor.repository = repository
        
        interactor.intialFetchArticle(at: 0)
        
        queue.sync { }
   
        XCTAssertTrue(presenter.didFetchFirstArticleError)
        XCTAssertNil(presenter.currentArticle)
    }
    
    func testLoadNextArticle() {
        
        let repository = MockArticleRepository(response: .hit)
        interactor.repository = repository
        
        interactor.loadNextArticle(for: 0)
 
        queue.sync { }

        XCTAssertTrue(presenter.didFetchNextArticle)
        XCTAssertNotNil(presenter.nextArticle)
    }
    
    func testLoadNextArticleEmpty() {
        
        let repository = MockArticleRepository(response: .miss)
        interactor.repository = repository
        
        interactor.loadNextArticle(for: 0)
        
        queue.sync { }

        XCTAssertTrue(presenter.didFetchNextArticle)
        XCTAssertNil(presenter.nextArticle)
    }
    
    func testLoadPreviousArticle() {
        
        let repository = MockArticleRepository(response: .hit)
        interactor.repository = repository
        
        interactor.loadPreviousArticle(for: 1)
        
        queue.sync { }

        XCTAssertTrue(presenter.didFetchPreviousArticle)
        XCTAssertNotNil(presenter.previousArticle)
    }
    
    func testLoadPreviousArticleWithInvalidIndex() {
        
        let repository = MockArticleRepository(response: .hit)
        interactor.repository = repository
        
        interactor.loadPreviousArticle(for: -1)
        
        queue.sync { }

        XCTAssertTrue(presenter.didFetchPreviousArticle)
        XCTAssertNil(presenter.previousArticle)
    }
    
    func testLoadPreviousArticleEmpty() {
        
        let repository = MockArticleRepository(response: .miss)
        interactor.repository = repository
        
        interactor.loadPreviousArticle(for: 1)
        
        queue.sync { }

        XCTAssertTrue(presenter.didFetchPreviousArticle)
        XCTAssertNil(presenter.previousArticle)
    }
}
