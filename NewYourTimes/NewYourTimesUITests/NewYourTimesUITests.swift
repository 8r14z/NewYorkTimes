//
//  NewYourTimesUITests.swift
//  NewYourTimesUITests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import XCTest



class NewYourTimesUITests: XCTestCase {

    var app: XCUIApplication!
    override func setUp() {

        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }
    
    func testShowHome() {
        sleep(3)
        let cell = app.collectionViews.cells.firstMatch
        XCTAssert(cell.exists)
    }

    func testScrollOnOfContent() {
        sleep(3)
        app.collectionViews.cells.firstMatch.swipeUp()
        app.collectionViews.cells.firstMatch.swipeUp()
        app.collectionViews.cells.firstMatch.swipeUp()
    }
    
    func testScrollDownToShowSearchBar() {
        sleep(3)
        app.collectionViews.cells.firstMatch.swipeDown()
        let searchBar = app.searchFields.firstMatch
        XCTAssert(searchBar.exists)
    }
    
    func testSearchArticleBySearchBar() {
        sleep(3)
        app.collectionViews.cells.firstMatch.swipeDown()
        app.searchFields.firstMatch.tap()
        app.searchFields.firstMatch.typeText("Sd")
        sleep(5)
        app.collectionViews.cells.firstMatch.swipeUp()
    }
    
    func testShowArticleDetail() {
        sleep(3)
        app.collectionViews.cells.firstMatch.tap()
        let cell = app.collectionViews.children(matching: .cell).element(boundBy: 0)
        XCTAssertTrue(cell.exists)
    }
    
    func testSwipeBetwwenArticles() {
        sleep(3)
        app.collectionViews.cells.firstMatch.tap()
        app.collectionViews.cells.firstMatch.swipeLeft()
        app.collectionViews.cells.firstMatch.swipeLeft()
        app.collectionViews.cells.firstMatch.swipeLeft()
        app.collectionViews.cells.firstMatch.swipeRight()
        app.collectionViews.cells.firstMatch.swipeRight()
        sleep(1)
    }
    
    
}
