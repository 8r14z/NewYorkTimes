//
//  BaseProtocol.swift
//  NewYourTimes_Demo
//
//  Created by An Le  on 5/6/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation

/**
 Base Protocol for VIPER Architecture
 */


/**
 Base Protocol for all Views/View Controllers
 */
protocol BaseViewProtocol {
    
    associatedtype Presenter: BasePresenterProtocol
    
    var presenter: Presenter { get set }
}



/**
 Base Protocol for Presenter which is the central of all other components.
 */
protocol BasePresenterProtocol {
    
    associatedtype Interactor: BaseInteractorProtocol
    associatedtype Router: BaseRouterProtocol
    
    var interactor: Interactor { get set }
    var router: Router { get set }
}



/**
 Base Protocol for Interactor which contains all business logic
 */
protocol BaseInteractorProtocol {
    
    associatedtype Presenter: BasePresenterProtocol
    associatedtype DataRepository: BaseDataRepositoryProtocol
    
    var presenter: Presenter { get set }
}



/**
 Base Protocol for Router which is responsible for the segues between the VIPER modules
 */
protocol BaseRouterProtocol {

}



/**
 Base Protocol for Data Access Layer which may contain multiple data source (local, cloud,...)
 */
protocol BaseDataRepositoryProtocol {
    
    associatedtype DataSource: BaseDataSourceProtocol
    
    var dataSources: [DataSource] { get set }
}


protocol BaseDataSourceProtocol {
    
}
