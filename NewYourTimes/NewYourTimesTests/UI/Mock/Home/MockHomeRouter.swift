//
//  MockHomeRouter.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit
@testable import NewYourTimes



class MockHomeRouter: HomeRouterProtocol {
    
    var didNavigateToSearchView = false
    var didNavigationToArticleView = false
    
    var sectionIndex: Int = -1
    
    static func makeHomeView() -> UIViewController {
        return UIViewController()
    }
    
    func navigateToSearchArticleView(from view: HomeViewProtocol) {
        didNavigateToSearchView = true
    }
    
    func navigateToArticleView(from view: HomeViewProtocol, sectionIndex: Int) {
        self.sectionIndex = sectionIndex
        didNavigationToArticleView = true
    }
}
