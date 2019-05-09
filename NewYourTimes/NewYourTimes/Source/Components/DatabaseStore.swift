//
//  UDDatabaseStore.swift
//  NewYourTimes
//
//  Created by An Le  on 5/9/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



protocol DatabaseStoring {
    
    func fetchData(forKey key: String) -> [Any]?
    func saveData<T>(_ data: T, forKey key: String)
    func removeAllData(forKey key: String)
}



extension UserDefaults: DatabaseStoring {

    func fetchData(forKey key: String) -> [Any]? {
        return array(forKey: key)
    }
    
    func saveData<T>(_ data: T, forKey key: String) {
        
        if var allData = fetchData(forKey: key) {
            allData.insert(data, at: 0)
            set(allData, forKey: key)
            
        } else {
            set([data], forKey: key)
        }
    }
    
    func removeAllData(forKey key: String) {
        set(nil, forKey: key)
    }
}

