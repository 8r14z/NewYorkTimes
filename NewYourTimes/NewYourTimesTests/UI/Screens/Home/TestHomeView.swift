//
//  TestHomeView.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest
@testable import NewYourTimes



class TestHomeView: XCTestCase {
    
    var view: HomeViewController!
    var presenter: MockHomePresenter!
    override func setUp() {
        super.setUp()
        
        presenter = MockHomePresenter()
        view = HomeViewController()
        view.presenter = presenter
    }
    
    func testDidPullToRefresh() {
        view.didPullToRefreshSections()
        XCTAssertTrue(presenter.didPullToRefreshData)
    }
    
    func testShowLoading() {
        view.showLoadingIndicator()
        XCTAssertTrue(view.loadingIndicator.isAnimating)
    }
    
    func testHideLoading() {
        view.hideLoadingIndicator()
        XCTAssertFalse(view.loadingIndicator.isAnimating)
    }
    
    func testHidePullToRefresh() {
        view.hidePullToRefreshIndicator()
        XCTAssertFalse(view.refreshControl.isRefreshing)
    }
    
    
    func testReloadView() {
        
        let article = HomeArticleSection(title: "", snippet: "", publishedDate: Date(), image: nil)
        var sections = view.sectionViewModelsForAdapter(view.acvAdapter)
        
        XCTAssert(sections.isEmpty)

        view.reloadView(with: [article])

        sections = view.sectionViewModelsForAdapter(view.acvAdapter)
        
        XCTAssert(!sections.isEmpty)
    }
    
    func testUpdateViewWithNewArticles() {
        
        let article = HomeArticleSection(title: "", snippet: "", publishedDate: Date(), image: nil)
        var sections = view.sectionViewModelsForAdapter(view.acvAdapter)
        
        XCTAssert(sections.isEmpty)
        
        view.updateView(with: [article])
        
        sections = view.sectionViewModelsForAdapter(view.acvAdapter)
        
        XCTAssert(!sections.isEmpty)
    }
    
    func testDidSelectSection() {
        
        let article = HomeArticleSection(title: "", snippet: "", publishedDate: Date(), image: nil)
        let sections = view.sectionViewModelsForAdapter(view.acvAdapter)
        
        XCTAssert(sections.isEmpty)
        
        view.updateView(with: [article])
        
        let section = 0
        
        view.didSelectSection(section)
        
        XCTAssertTrue(presenter.didSelectSection)
        XCTAssert(presenter.selectedSection == section)
    }
    
    func testWillDisplaySection() {
        
        let article = HomeArticleSection(title: "", snippet: "", publishedDate: Date(), image: nil)
        let sections = view.sectionViewModelsForAdapter(view.acvAdapter)
       
        XCTAssert(sections.isEmpty)
        
        view.updateView(with: [article])
        
        let section = 0
        
        view.willDisplaySection(section: section)
        
        XCTAssertTrue(presenter.willDisplaySection)
        XCTAssert(presenter.displaySection == section)
    }
    
    func testDidTappSearchItem() {
        
        view.didTapSearchItem()
        
        if #available(iOS 11.0, *) {
            XCTAssertFalse(presenter.didSelectSearchItem)
        } else {
            XCTAssertTrue(presenter.didSelectSearchItem)
        }
    }
}
