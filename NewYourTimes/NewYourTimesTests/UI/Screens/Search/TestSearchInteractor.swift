//
//  TestSearchInteractor.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest
@testable import NewYourTimes



class TestSearchInteractor: XCTestCase {
    
    var presenter: MockSearchPresenter!
    var interactor: SearchInteractor!
    var queue = DispatchQueue(label: "TestSearchInteractorQueue")
    
    override func setUp() {
        super.setUp()
        
        presenter = MockSearchPresenter()
        interactor = SearchInteractor()
        interactor.presenter = presenter
        interactor.requestQueue = queue
    }
    
    func testFetchPreviousKeywords_Empty() {
        
        let repository = MockSearchRepository(response: .miss)
        interactor.repository = repository
        
        interactor.fetchPreviousKeywords()
        
        queue.sync { }
        
        XCTAssertTrue(presenter.didFetchKeywords)
        XCTAssertNotNil(presenter.keywords)
        XCTAssert(presenter.keywords!.isEmpty)
    }
    
    func testFetchPrevious10Keywords() {
        
        let repository = MockSearchRepository(response: .hit)
        interactor.repository = repository
        
        interactor.fetchPreviousKeywords()
        
        queue.sync { }
        
        XCTAssertTrue(presenter.didFetchKeywords)
        XCTAssertNotNil(presenter.keywords)
        XCTAssert(presenter.keywords?.count == 10)
    }
    
    func testSaveKeyword() {

        let repository = MockSearchRepository(response: .error)
        interactor.repository = repository
        
        interactor.saveKeyword("keyword")
        
        queue.sync { }
        
        XCTAssertNotNil(repository.searchTerm)
        XCTAssert(repository.searchTerm! == "keyword")
    }
    
    func testFetchSearchArticlesSuccess() {
        
        let repository = MockSearchRepository(response: .hit)
        interactor.repository = repository
    
        interactor.fetchSearchArticles(with: "keyword")
        
        queue.sync { }
        
        XCTAssertTrue(presenter.didFetchArticlesSuccess)
        XCTAssertNotNil(presenter.articles)
        XCTAssertTrue(!presenter.articles!.isEmpty)
    }
    
    func testFetchSearchArticlesEmpty() {
        
        let repository = MockSearchRepository(response: .miss)
        interactor.repository = repository
        
        interactor.fetchSearchArticles(with: "keyword")
        
        queue.sync { }
        
        XCTAssertTrue(presenter.didFetchArticlesSuccess)
        XCTAssertNotNil(presenter.articles)
        XCTAssertTrue(presenter.articles!.isEmpty)
    }
    
    func testFetchSearchArticlesError() {
        
        let repository = MockSearchRepository(response: .error)
        interactor.repository = repository
        
        interactor.fetchSearchArticles(with: "keyword")
        
        queue.sync { }
        
        XCTAssertTrue(presenter.didFetchArticlesError)
        XCTAssertNil(presenter.articles)
    }
}
