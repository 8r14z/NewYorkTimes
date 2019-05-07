//
//  BaseInteractorProtocol.swift
//  NewYourTimes_Demo
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



/**
 Base Protocol for Interactor which contains all business logic
 */
protocol BaseInteractorProtocol {
    
    associatedtype Presenter: BasePresenterProtocol
    associatedtype DataRepository: BaseDataRepositoryProtocol
    
    var presenter: Presenter { get set }
}
