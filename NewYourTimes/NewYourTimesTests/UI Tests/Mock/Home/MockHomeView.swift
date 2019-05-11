//
//  MockHomeView.swift
//  NewYourTimesTests
//
//  Created by An Le  on 5/11/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit
@testable import NewYourTimes



class MockHomeView: UIViewController, HomeViewProtocol {
    
    var presenter: HomePresenterProtocol?
    
    var didPullToRefresh = false
    
    var didShowError = false
    var didShowLoading = false
    var didHideLoading = false
    var didHidePullToRefresh = false
    var didReloadView = false
    var didUpdateView = false
    
    var homeArticleSections: [HomeArticleSection]?
    
    func showError(_ error: Error) {
        didShowError = true
    }
    
    func showLoadingIndicator() {
        didShowLoading = true
    }
    
    func hideLoadingIndicator() {
        didHideLoading = true
    }
    
    func hidePullToRefreshIndicator() {
        didHidePullToRefresh = true
    }
    
    func reloadView(with data: [HomeArticleSection]) {
        homeArticleSections = data
        didReloadView = true
    }
    
    func updateView(with newData: [HomeArticleSection]) {
        homeArticleSections = newData
        didUpdateView = true
    }
    
    
}
