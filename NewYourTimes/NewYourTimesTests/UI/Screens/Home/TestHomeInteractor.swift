//
//  TestHomeInteractor.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest
@testable import NewYourTimes



class TestHomeInteractor: XCTestCase {
    
    var presenter: MockHomePresenter!
    var interactor: HomeInteractor!
    
    override func setUp() {
        presenter = MockHomePresenter()
        interactor = HomeInteractor()
        interactor.presenter = presenter
    }
    
    func testInitialFetchArticlesSuccess() {
        
        let repository = MockArticleRepository(response: .hit)
        interactor.repository = repository
        
        interactor.initialFetchArticles()
        
        Thread.sleep(forTimeInterval: 0.3)

        XCTAssertNotNil(presenter.articles)
        XCTAssert(presenter.articles!.count == repository.articles!.count)
        XCTAssertTrue(presenter.didIntialFetchSuccess)
        XCTAssertFalse(presenter.didInitialFetchError)
    }

    func testInitialFetchArticlesSuccessFail() {
        
        interactor.repository = MockArticleRepository(response: .error)
        
        interactor.initialFetchArticles()
        
        Thread.sleep(forTimeInterval: 0.3)
        
        XCTAssertNil(presenter.articles)
        XCTAssertTrue(presenter.didInitialFetchError)
        XCTAssertFalse(presenter.didIntialFetchSuccess)
    }
    
    func testFetchArticlesSuccess() {
        
        let repository = MockArticleRepository(response: .hit)
        interactor.repository = repository
        
        interactor.fetchArticles()
        
        Thread.sleep(forTimeInterval: 0.3)
        
        XCTAssertNotNil(presenter.articles)
        XCTAssert(presenter.articles!.count == repository.articles!.count)
        XCTAssertTrue(presenter.didFetchSuccess)
        XCTAssertFalse(presenter.didFetchError)
    }
    
    func testFetchArticlesError() {
        
        interactor.repository = MockArticleRepository(response: .error)
        
        interactor.fetchArticles()
        
        Thread.sleep(forTimeInterval: 0.3)
        
        XCTAssertNil(presenter.articles)
        XCTAssertTrue(presenter.didFetchError)
        XCTAssertFalse(presenter.didFetchSuccess)
    }
}



