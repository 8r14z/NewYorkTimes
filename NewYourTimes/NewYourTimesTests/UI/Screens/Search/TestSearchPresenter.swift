//
//  TestSearchPresenter.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest
@testable import NewYourTimes



class TestSearchPresenter: XCTestCase {
    
    
    var presenter: SearchPresenter!
    var interactor: MockSearchInteractor!
    var view: MockSearchView!
    
    override func setUp() {
        super.setUp()
        
        view = MockSearchView()
        interactor = MockSearchInteractor()
        presenter = SearchPresenter()
        presenter.view = view
        presenter.interactor = interactor
    }
    
    func testSeacrchBarDidBeginEditing() {
        
        presenter.searchBarDidBeginEditing()
        
        XCTAssertTrue(interactor.didFetchKeywords)
    }
    
    func testDidSelectKeyword() {
        
        let keyword = "This is an keyword"
        presenter.didSelectSearchKeyword(keyword)
        
        XCTAssertTrue(view.didUpdateSearchBarText)
        XCTAssertNotNil(view.searchText)
        XCTAssert(view.searchText! == keyword)
        XCTAssertTrue(view.didResignFirstResponder)
        XCTAssertTrue(view.didShowLoadingIndicator)
        XCTAssertTrue(interactor.didFetchArticles)
        XCTAssertNotNil(interactor.searchKeyword)
        XCTAssert(interactor.searchKeyword! == keyword)
    }
    
    func testSearchTextDidChange_EmptyText() {
        
        presenter.searchBarTextDidChange("")
        
        XCTAssertTrue(interactor.didFetchKeywords)
    }
    
    func testSearchTextDidChange_RealtimeSearch() {
        
        let keyword = "This is a keyword"
        presenter.searchBarTextDidChange(keyword)
        
        let promise = expectation(description: "")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(view.didShowLoadingIndicator)
        XCTAssertTrue(interactor.didFetchArticles)
    }
    
    func testSearchBarButtonDidClick() {
        
        let keyword = "This is a keyword"
        presenter.searchBarButtonDidEnter(keyword)
        
        XCTAssertTrue(interactor.didSaveKeyword)
        XCTAssertNotNil(interactor.saveKeyword)
        XCTAssert(interactor.saveKeyword! == keyword)
        XCTAssertTrue(view.didShowLoadingIndicator)
        XCTAssertTrue(interactor.didFetchArticles)
        XCTAssertNotNil(interactor.searchKeyword)
        XCTAssert(interactor.searchKeyword! == keyword)
    }
    
    func testDidFetchPreviousKeywords_Empty() {
        
        presenter.didFetchKeywords([])
        
        let promise = expectation(description: "")
        
        DispatchQueue.main.async {
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(view.didReloadView)
        XCTAssertTrue(view.didShowEmptyView)
    }
    
    func testDidFetchPreviousKeywords() {
        
        let keywords = ["k1", "k2"]
        presenter.didFetchKeywords(keywords)
        
        let promise = expectation(description: "")
        
        DispatchQueue.main.async {
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(view.didHideEmptyView)
        XCTAssertTrue(view.didReloadView)
        XCTAssertNotNil(view.sectionModels)
        XCTAssert(view.sectionModels!.count == keywords.count)
    }
    
    func testDidFetchSearchArticleSuccess_Empty() {
        
        presenter.didFetchSearchArticleSuccess([])
        
        let promise = expectation(description: "")
        
        DispatchQueue.main.async {
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(view.didReloadView)
        XCTAssertTrue(view.didHideLoadingIndocator)
        XCTAssertTrue(view.didShowEmptyView)
    }
    
    func testDidFetchSearchArticleSuccess() {
        
        presenter.didFetchSearchArticleSuccess([TestSearchArticle])
        
        let promise = expectation(description: "")
        
        DispatchQueue.main.async {
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(view.didReloadView)
        XCTAssertTrue(view.didHideLoadingIndocator)
        XCTAssertTrue(view.didHideEmptyView)
        XCTAssertNotNil(view.sectionModels)
    }
    
    func testDidFetchSearchArticleError() {
        
        presenter.didFetchSearchArticlesError(TestError)
        
        let promise = expectation(description: "")
        
        DispatchQueue.main.async {
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(view.didHideLoadingIndocator)
        XCTAssertTrue(view.didShowError)
        XCTAssertNil(view.sectionModels)
    }
}




