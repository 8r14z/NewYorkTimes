//
//  ACVViewController.swift
//  NewYourTimes
//
//  Created by An Le  on 5/9/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



class ACVViewController: UICollectionViewController {
    
    lazy private(set)var acvAdapter: ACVAdapter = {
        let adapter = ACVAdapter()
        adapter.collectionView = collectionView
        return adapter
    }()
    
    lazy private(set)var refreshControl: UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        return refresher
    }()
    
    lazy private(set)var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        view.addSubview(indicator)
        indicator.constraintCenter(to: view)
        return indicator
    }()
    
    lazy private(set)var emptyLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        view.addSubview(label)
        label.constraintFill(to: view)
        return label
    }()
    
    var isPullToRefreshEnabled: Bool {
        return true
    }

    init() {
        let flowLayout = ACVFlowLayout()
            .autoSizing(false)
            .minimumLineSpacing(0)
            .sectionInset(top: 0, left: 0, bottom: 10, right: 0)
        
        super.init(collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: === Life Cycle ===
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isPullToRefreshEnabled {
            collectionView.addSubview(refreshControl)
        }
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    
    
    // MARK: === Convenient ===
    func showError(_ error: Error) {
        
        let alertController = UIAlertController(title: "Something went wrong", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(
            UIAlertAction(title: "OK", style: .cancel, handler: nil)
        )
        
        present(alertController, animated: true, completion: nil)
    }
    
    /// To override by sub class
    func didPullToRefreshSections() { }
    
    @objc private func didPullToRefresh() {
        didPullToRefreshSections()
    }
}
