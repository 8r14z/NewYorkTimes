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
        
        let interactor = HomeInteractor()
        interactor.presenter = mockPresenter
        interactor.repository = MockArticleRepository(response: .hit)
        
        interactor.initialFetchArticles()
        
        Thread.sleep(forTimeInterval: 0.3)

        XCTAssertTrue(mockPresenter.didIntialFetchSuccess)
    }

    func testInitialFetchArticlesSuccessFail() {
        
        let interactor = HomeInteractor()
        interactor.presenter = mockPresenter
        interactor.repository = MockArticleRepository(response: .error)
        
        interactor.initialFetchArticles()
        
        Thread.sleep(forTimeInterval: 0.3)
        
        XCTAssertTrue(mockPresenter.didInitialFetchError)
        XCTAssertFalse(mockPresenter.didIntialFetchSuccess)
    }
    
    func testFetchArticlesSuccess() {
        
        let interactor = HomeInteractor()
        interactor.presenter = mockPresenter
        interactor.repository = MockArticleRepository(response: .hit)
        
        interactor.fetchArticles()
        
        Thread.sleep(forTimeInterval: 0.3)
        
        XCTAssertTrue(mockPresenter.didFetchSuccess)
        XCTAssertFalse(mockPresenter.didFetchError)
    }
    
    func testFetchArticlesError() {
        
        let interactor = HomeInteractor()
        interactor.presenter = mockPresenter
        interactor.repository = MockArticleRepository(response: .hit)
        
        interactor.fetchArticles()
        
        Thread.sleep(forTimeInterval: 0.3)
        
        XCTAssertTrue(mockPresenter.didFetchError)
        XCTAssertFalse(mockPresenter.didFetchSuccess)
    }
}



