//
//  ServiceProvider.swift
//  NewYourTimes
//
//  Created by An Le  on 5/8/19.
//  Copyright © 2019 An Le. All rights reserved.
//

import Foundation



protocol Cancellable: ClassOnly {
    
    func cancel()
}



protocol ServiceProviding {
    @discardableResult
    func downloadData(with url: URL, completion: ReadCompletionBlock<Data?>?) -> Cancellable
    @discardableResult
    func download(with url: URL, completion: ReadCompletionBlock<JSON>?) -> Cancellable
}



protocol URLSessionProtocol {
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}



extension URLSession: URLSessionProtocol { }
extension URLSessionDataTask: Cancellable { }



class ServiceProvider: ServiceProviding {
    
    static let `default` = ServiceProvider()
    
    var urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession(configuration: .default)) {
        self.urlSession = urlSession
    }
    
    @discardableResult
    func downloadData(with url: URL, completion: ReadCompletionBlock<Data?>?) -> Cancellable {
        
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion?(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    completion?(.failure(NetworkError.unexpected))
                    return
            }
            
            completion?(.success(data))
        }
        
        task.resume()
        return task
    }
    
    @discardableResult
    func download(with url: URL, completion: ReadCompletionBlock<JSON>?) -> Cancellable {
        
        return downloadData(with: url, completion: { (result) in
            
            switch result {
            case .success(let data):
                
                if let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data) as? JSON {
                    completion?(.success(json))
                } else {
                    completion?(.success([:]))
                }
                
            case .failure(let error):
                completion?(.failure(error))
            }
        })
    }
}
