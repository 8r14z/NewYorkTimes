//
//  BasePresenterProtocol.swift
//  NewYourTimes_Demo
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



/**
 Base Protocol for Presenter which is the central of all other components.
 */
protocol BasePresenterProtocol {
    
    associatedtype Interactor: BaseInteractorProtocol
    associatedtype Router: BaseRouterProtocol
    
    var interactor: Interactor { get set }
    var router: Router { get set }
}
