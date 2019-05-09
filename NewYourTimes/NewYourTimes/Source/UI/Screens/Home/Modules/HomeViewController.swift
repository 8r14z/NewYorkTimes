//
//  HomeViewController.swift
//  NewYourTimes
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



class HomeViewController: ACVViewController, HomeViewProtocol {

    var presenter: HomePresenterProtocol?

    private(set)var articleSections = [HomeArticleSection]()
    
    lazy var searchController: UISearchController = {
        return SearchRouter.makeSearchView()
    }()
    
    private var viewDidAppearOnceToken = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = true
        } else {
            let searchItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearchItem))
            navigationItem.rightBarButtonItem = searchItem
        }
                
        navigationItem.title = "News".localized()
        
        definesPresentationContext = true
        
        acvAdapter.dataSource = self
        acvAdapter.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        if !viewDidAppearOnceToken {
            viewDidAppearOnceToken = true
        
            presenter?.viewDidAppear()
        }
        
    }
    
    override func didPullToRefreshSections() {
        presenter?.didPullToRefresh()
    }
}



extension HomeViewController {
    
    func showLoadingIndicator() {
        loadingIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
    }
    
    func hidePullToRefreshIndicator() {
        refreshControl.endRefreshing()
    }
    
    func reloadView(with data: [HomeArticleSection]) {
        articleSections = data
        acvAdapter.reloadAllSections()
    }
    
    func updateView(with newData: [HomeArticleSection]) {
        articleSections.append(contentsOf: newData)
        acvAdapter.performUpdate()
    }
}



extension HomeViewController: ACVAdapterDataSource {
    
    func sectionViewModelsForAdapter(_ adapter: ACVAdapter) -> [SectionViewModel] {
        return articleSections
    }
}



// MARK: === USER INTERACTION ===
extension HomeViewController: ACVAdapterDelegate {

    func didSelectSection(_ section: Int) {
        presenter?.didSelectSection(articleSections[section])
    }
    
    func willDisplaySection(section: Int) {
        presenter?.willDisplaySection(articleSections[section], sectionIndex: section, sectionCount: articleSections.count)
    }

    @objc func didTapSearchItem() {
        if #available(iOS 11.0, *) {
            // delegate presentation to view controller.
        } else {
            presenter?.didSelectSearch()
        }
    }
}
