//
//  HomeViewController.swift
//  NewYourTimes
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



class HomeViewController: UICollectionViewController, HomeViewProtocol {

    var presenter: HomePresenterProtocol?

    lazy var acvAdapter: ACVAdapter = {
        return ACVAdapter()
    }()
    
    private let refreshControl: UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        return refresher
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let flowLayout = ACVFlowLayout()
            .autoSizing(false)
            .minimumLineSpacing(0)
            .sectionInset(top: 0, left: 0, bottom: 10, right: 0)
        
        collectionView.collectionViewLayout = flowLayout
        collectionView.addSubview(refreshControl)
        
        view.addSubview(loadingIndicator)
        loadingIndicator.constraintCenter(to: view)
        
        navigationItem.title = "News".localized()
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        acvAdapter.collectionView = collectionView
        acvAdapter.dataSource = self
        acvAdapter.delegate = self
        
        presenter?.viewDidAppear()
    }
    
    override class func storyboardName() -> String {
        return "Home"
    }
}



extension HomeViewController {
    
    func showError(_ error: Error) {
        
        let alertController = UIAlertController(title: "Something went wrong", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(
            UIAlertAction(title: "OK", style: .cancel, handler: nil)
        )
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showLoadingIndicator() {
        loadingIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        loadingIndicator.stopAnimating()
    }
    
    func hidePullToRefreshIndicator() {
        refreshControl.endRefreshing()
    }
    
    func performUpdateView() {
        acvAdapter.performUpdate()
    }
}



extension HomeViewController: ACVAdapterDataSource {
    
    func sectionViewModelsForAdapter(_ adapter: ACVAdapter) -> [SectionViewModel] {
        
        if let presenter = presenter as? HomePresenter {
            return presenter.articleSections
        } else {
            return []
        }
    }
}



// MARK: === USER INTERACTION ===
extension HomeViewController: ACVAdapterDelegate {

    func didSelectItem(_ item: ItemViewModel, atIndexPath indexPath: IndexPath) {
        presenter?.didSelectSection(indexPath.section)
    }
    
    func willDisplaySection(section: Int) {
        presenter?.willDisplaySection(section)
    }
    
    @objc func didPullToRefresh() {
        presenter?.didPullToRefresh()
    }
}



