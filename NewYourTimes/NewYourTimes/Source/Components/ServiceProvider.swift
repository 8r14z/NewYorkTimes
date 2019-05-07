//
//  ServiceProvider.swift
//  NewYourTimes
//
//  Created by An Le  on 5/8/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



protocol ServiceProviding {
    func download(with request: URLRequest, completion: ReadCompletionBlock<JSON>?)
}



/// ServiceProvider
extension URLSession: ServiceProviding {
    
    func download(with request: URLRequest, completion: ReadCompletionBlock<JSON>?) {
        
        dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                completion?(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    completion?(.failure(NetworkError.unexpected))
                    return
            }
            
            if let data = data,
                let json = try? JSONSerialization.jsonObject(with: data) as? JSON {
                completion?(.success(json))
            } else {
                completion?(.success([:]))
            }
            
        }.resume()
    }
    
    
}
