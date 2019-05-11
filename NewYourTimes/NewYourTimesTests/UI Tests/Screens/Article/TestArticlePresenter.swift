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
    
    func testWillTransitionToNextArticle() {
        
        let currentArticle = ArticleDetailSection(title: "", publishedDate: Date(), publisher: "", author: "", snippet: "", image: nil, pageIndex: 0)
        
        let nextArticle = ArticleDetailSection(title: "", publishedDate: Date(), publisher: "", author: "", snippet: "", image: nil, pageIndex: 1)
        
        presenter.willTransitionFromArticle(currentArticle, to: nextArticle)
        
        XCTAssertNil(presenter.nextArticle)
        XCTAssertNotNil(presenter.previousArticle)
        XCTAssertNotNil(presenter.currentArticle)
        XCTAssertTrue(interactor.didLoadNext)
    }

    func testWillTransitionToPreviousArticle() {

        let currentArticle = ArticleDetailSection(title: "", publishedDate: Date(), publisher: "", author: "", snippet: "", image: nil, pageIndex: 1)
        
        let nextArticle = ArticleDetailSection(title: "", publishedDate: Date(), publisher: "", author: "", snippet: "", image: nil, pageIndex: 0)
        
        presenter.willTransitionFromArticle(currentArticle, to: nextArticle)
        
        XCTAssertNil(presenter.previousArticle)
        XCTAssertNotNil(presenter.nextArticle)
        XCTAssertNotNil(presenter.currentArticle)
        XCTAssertTrue(interactor.didLoadPrevious)
    }
    
    func testDidInitialFetchSuccess() {
        
        presenter.didInitialFetchSuccess(TestArticle, index: 0)
        
        let promise = expectation(description: "")
        DispatchQueue.main.async {
            promise.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(presenter.currentArticle)
        XCTAssertTrue(view.didUpdateView)
        XCTAssertTrue(interactor.didLoadNext)
        XCTAssertTrue(interactor.didLoadPrevious)
    }
    
    func testDidInitialFetchError() {
        
        presenter.didInitialFetchError(TestError)
        
        let promise = expectation(description: "")
        DispatchQueue.main.async {
            promise.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNil(presenter.currentArticle)
        XCTAssertTrue(view.didShowError)
    }
    
    func testDidLoadNextArticle() {
        
        presenter.didLoadNextArticle(TestArticle, index: 0)
        
        let promise = expectation(description: "")
        DispatchQueue.main.async {
            promise.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(presenter.nextArticle)
    }
    
    func testDidLoadNextArticleEmpty() {
        
        presenter.didLoadNextArticle(nil, index: 0)
        
        let promise = expectation(description: "")
        DispatchQueue.main.async {
            promise.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNil(presenter.nextArticle)
    }
    
    func testDidLoadPreviousArticle() {
        
        presenter.didLoadPreviousArticle(TestArticle, index: 0)
        
        let promise = expectation(description: "")
        DispatchQueue.main.async {
            promise.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(presenter.previousArticle)
    }
    
    func testDidLoadPreviousArticleEmpty() {
        
        presenter.didLoadPreviousArticle(nil, index: 0)
        
        let promise = expectation(description: "")
        DispatchQueue.main.async {
            promise.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNil(presenter.previousArticle)
    }
}
