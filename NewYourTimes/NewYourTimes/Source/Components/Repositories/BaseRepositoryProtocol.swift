//
//  BaseRepositoryProtocol.swift
//  NewYourTimes_Demo
//
//  Created by An Le  on 5/7/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



/**
 Base Protocol for Data Access Layer which may contain multiple data source (local, cloud,...)
 */
protocol BaseDataRepositoryProtocol {
    
    associatedtype DataSource: BaseDataSourceProtocol
    
    var localDataSource: DataSource { get set }
    var cloudDataSource: DataSource { get set }
}


protocol BaseDataSourceProtocol {
    
    // Data Access
    func fetchData<T>(completion: ReadCompletionBlock<T>?)
    func saveData<T>(_ data: [T], completion: WriteCompletionBlock?)
    func updateData<T>(_ data: [T], completion: WriteCompletionBlock?)
    func deleteData<T>(_ data: [T], completion: WriteCompletionBlock?)
}


typealias ReadCompletionBlock<T> = ((Result<[T], Error>) -> Void)
typealias WriteCompletionBlock = ((_ successed: Bool) -> Void)
