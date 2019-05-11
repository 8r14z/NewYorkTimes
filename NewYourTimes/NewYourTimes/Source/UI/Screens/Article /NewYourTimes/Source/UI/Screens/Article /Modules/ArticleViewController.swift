//
//  ArticleViewController.swift
//  NewYourTimes
//
//  Created by An Le  on 5/9/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import UIKit



class ArticleViewController: UIPageViewController, ArticleViewProtocol {
    
    var presenter: ArticlePresenterProtocol?
    
    init() {
        super.init(transitionStyle: .scroll,
                   navigationOrientation: .horizontal,
                   options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
        
        view.backgroundColor = .separator
        
        dataSource = self
        delegate = self
        
        presenter?.initialSetup()
    }
}



extension ArticleViewController  {
    
    func updateViewWithArticle(_ article: ArticleDetailSection) {
        let articleDetailVC = ArticleDetailView(articleSection: article)
        setViewControllers([articleDetailVC], direction: .forward, animated: false, completion: nil)
    }
    
    func showError(_ error: Error) {
        //
    }
}



// MARK: === USER INTERACTION ===
extension ArticleViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
        if let articleDetailView = pendingViewControllers.first as? ArticleDetailView {
            let article = articleDetailView.articleSection
            presenter?.willTransitionToArticle(article)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let section = presenter?.previousArticle {
            return ArticleDetailView(articleSection: section)
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let section = presenter?.nextArticle {
            return ArticleDetailView(articleSection: section)
        } else {
            return nil
        }
    }
}
