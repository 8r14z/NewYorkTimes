//
//  TestHomePrenseter.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest
@testable import NewYourTimes



class TestHomePresenter: XCTestCase {
    
    var view: MockHomeView!
    var router: MockHomeRouter!
    var interactor: MockHomeInteractor!
    var presenter: HomePresenter!
    
    override func setUp() {
        super.setUp()
        
        view = MockHomeView()
        router = MockHomeRouter()
        interactor = MockHomeInteractor()
        presenter = HomePresenter()
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
    }
    
    func testViewDidAppear() {
        
        presenter.initialSetup()
        
        XCTAssertTrue(view.didShowLoading)
        XCTAssertTrue(interactor.didIntialFetch)
    }
    
    func testDidPullToRefresh() {
        
        presenter.didPullToRefresh()
        
        XCTAssertTrue(interactor.didIntialFetch)
    }
    
    func testDidSelectSection() {
        
        let selectedIndex = 1
        presenter.didSelectSection(HomeArticleSection(title: "", snippet: "", publishedDate: Date(), image: nil),
                                   sectionIndex: selectedIndex)
        
        XCTAssertTrue(router.didNavigationToArticleView)
        XCTAssertTrue(router.sectionIndex == selectedIndex)
    }
    
    func testWillDisplaySection_WillReachTheEnd() {
        
        let sectionIndex = 8
        let totalSection = 10
        presenter.willDisplaySection(HomeArticleSection(title: "", snippet: "", publishedDate: Date(), image: nil), sectionIndex: sectionIndex, sectionCount: totalSection)
        
        XCTAssertTrue(interactor.didFetch)
    }
    
    func testWillDisplaySection_NotReachTheEnd() {
        
        let sectionIndex = 2
        let totalSection = 10
        presenter.willDisplaySection(HomeArticleSection(title: "", snippet: "", publishedDate: Date(), image: nil), sectionIndex: sectionIndex, sectionCount: totalSection)
        
        XCTAssertFalse(interactor.didFetch)
    }
    
    func testDidSelectSearch() {
        
        presenter.didSelectSearch()
        
        XCTAssertTrue(router.didNavigateToSearchView)
    }
    
    func testDidInitialFetchSuccess() {
        
        let articles = [TestArticle]
        presenter.didInitialFetchSuccess(articles)
        
        let promise = expectation(description: "")
        
        DispatchQueue.main.async {
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(view.didHideLoading)
        XCTAssertTrue(view.didReloadView)
        XCTAssertNotNil(view.homeArticleSections)
    }
    
    
    func testDidInitialFetchError() {
        
        presenter.didIntialFetchError(TestError)
        
        let promise = expectation(description: "")
        
        DispatchQueue.main.async {
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(view.didHideLoading)
        XCTAssertTrue(view.didShowError)
        XCTAssertNil(view.homeArticleSections)
    }
    
    func testDidFetchSuccess() {
        
        let articles = [TestArticle]
        presenter.didFetchSuccess(articles)
        
        let promise = expectation(description: "")
        
        DispatchQueue.main.async {
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(view.didUpdateView)
        XCTAssertNotNil(view.homeArticleSections)
    }
    
    func testDidFetchError() {
        
        presenter.didFetchError(TestError)
        
        let promise = expectation(description: "")
        
        DispatchQueue.main.async {
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(view.didShowError)
        XCTAssertNil(view.homeArticleSections)
    }
}
