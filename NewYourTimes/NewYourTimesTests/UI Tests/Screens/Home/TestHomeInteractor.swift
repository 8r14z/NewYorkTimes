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
    
    var mockPresenter: MockHomePresenter!
    
    override func setUp() {
        mockPresenter = MockHomePresenter()
    }
    
    func testInitialFetchArticlesSuccess() {
        
        let repository = MockArticleRepository(response: .hit)
        let interactor = HomeInteractor()
        interactor.presenter = mockPresenter
        interactor.repository = repository
        
        interactor.initialFetchArticles()
        
        Thread.sleep(forTimeInterval: 0.3)

        XCTAssertNotNil(mockPresenter.articles)
        XCTAssert(mockPresenter.articles!.count == repository.articles!.count)
        XCTAssertTrue(mockPresenter.didIntialFetchSuccess)
        XCTAssertFalse(mockPresenter.didInitialFetchError)
    }

    func testInitialFetchArticlesSuccessFail() {
        
        let interactor = HomeInteractor()
        interactor.presenter = mockPresenter
        interactor.repository = MockArticleRepository(response: .error)
        
        interactor.initialFetchArticles()
        
        Thread.sleep(forTimeInterval: 0.3)
        
        XCTAssertNil(mockPresenter.articles)
        XCTAssertTrue(mockPresenter.didInitialFetchError)
        XCTAssertFalse(mockPresenter.didIntialFetchSuccess)
    }
    
    func testFetchArticlesSuccess() {
        
        let repository = MockArticleRepository(response: .hit)
        let interactor = HomeInteractor()
        interactor.presenter = mockPresenter
        interactor.repository = repository
        
        interactor.fetchArticles()
        
        Thread.sleep(forTimeInterval: 0.3)
        
        XCTAssertNotNil(mockPresenter.articles)
        XCTAssert(mockPresenter.articles!.count == repository.articles!.count)
        XCTAssertTrue(mockPresenter.didFetchSuccess)
        XCTAssertFalse(mockPresenter.didFetchError)
    }
    
    func testFetchArticlesError() {
        
        let interactor = HomeInteractor()
        interactor.presenter = mockPresenter
        interactor.repository = MockArticleRepository(response: .error)
        
        interactor.fetchArticles()
        
        Thread.sleep(forTimeInterval: 0.3)
        
        XCTAssertNil(mockPresenter.articles)
        XCTAssertTrue(mockPresenter.didFetchError)
        XCTAssertFalse(mockPresenter.didFetchSuccess)
    }
}



