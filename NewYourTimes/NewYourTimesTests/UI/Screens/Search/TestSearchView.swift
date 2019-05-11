//
//  TestSearchView.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest
@testable import NewYourTimes



class TestSearchView: XCTestCase {
    
    var view: SearchViewController!
    var presenter: MockSearchPresenter!
    
    var searchController: UISearchController!
    
    override func setUp() {
        super.setUp()
        
        presenter = MockSearchPresenter()
        view = SearchViewController()
        view.presenter = presenter
        searchController = UISearchController(searchResultsController: view)
        view.searchBar = searchController.searchBar
    }
    
    func testShowEmptyView() {
        view.showEmptyView()
        XCTAssertFalse(view.emptyLabel.isHidden)
    }
    
    func testHideEmptyView() {
        view.hideEmptyView()
        XCTAssertTrue(view.emptyLabel.isHidden)
    }
    
    func testShowLoading() {
        view.showLoadingIndicator()
        XCTAssertTrue(view.loadingIndicator.isAnimating)
    }
    
    func testHideLoading() {
        view.hideLoadingIndicator()
        XCTAssertTrue(!view.loadingIndicator.isAnimating)
    }
    
    func testUpdateSearchBarText() {
        let text = "This is text"
        view.updateSearchBarText(text)
        XCTAssert(view.searchBar?.text == text)
    }
    
    func testRemoveFocusOnSearchBar() {
        view.removeFocusOnSearchBar()
        XCTAssertFalse(view.searchBar!.isFirstResponder)
    }
    
    func testReloadView() {
        
        let article = SearchArticleSection(title: "", snippet: "", publisher: "")
        var sections = view.sectionViewModelsForAdapter(view.acvAdapter)
        
        XCTAssert(sections.isEmpty)
        
        view.reloadView(with: [article])
        
        sections = view.sectionViewModelsForAdapter(view.acvAdapter)
        
        XCTAssert(!sections.isEmpty)
    }
    
    func testDidSelectSection() {
        
        let keyword = "This is a keyword"
        let article = SearchKeywordSection(keyword: keyword)
        let sections = view.sectionViewModelsForAdapter(view.acvAdapter)
        
        XCTAssert(sections.isEmpty)
        
        view.reloadView(with: [article])
        
        let section = 0
        
        view.didSelectSection(section)
        
        XCTAssertTrue(presenter.didSelectSearchKeyword)
        XCTAssertNotNil(presenter.searchKeyword)
        XCTAssert(presenter.searchKeyword! == keyword)
    }
    
    func testSearchBarDidBeginEditing() {
        view.searchBarTextDidBeginEditing(view.searchBar!)
        XCTAssertTrue(presenter.didBeginEditSearchBar)
    }
    
    func testSearchTextDidChange() {
        let change = "change"
        view.searchBar(view.searchBar!, textDidChange: change)
        XCTAssertTrue(presenter.didChangeSearchBarText)
        XCTAssert(presenter.searchKeyword! == change)
    }
    
    func testSearchButtonDidClick() {
        let text = "text"
        view.searchBar?.text = text
        view.searchBarSearchButtonClicked(view.searchBar!)
        XCTAssertTrue(presenter.didClickSearchButton)
        XCTAssert(presenter.searchKeyword == text)
    }
}
