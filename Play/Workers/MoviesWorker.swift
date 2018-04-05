//
//  MoviesWorker.swift
//  Play
//
//  Created by resource on 04/04/18.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import UIKit
import Foundation

//MARK: - MoviesWorker

typealias FetchResult = () -> Void
typealias JSONDictionary = [String:Any]

class MoviesWorker {
    
    var networkFetcher: NetworkFetcher
    let session: URLSession
    
    init(networkFetcher: NetworkFetcher) {
        self.networkFetcher = networkFetcher
        session = URLSession.shared
    }
    
}

protocol NetworkFetcher {
    func fetchJSON(onComplete: @escaping ((JSONDictionary?) -> Void))
    func fetchNewMovies(_ completion: @escaping ([Movie]) -> Void)
    //func fetchMovies(_ completion: @escaping (() throws -> [Movie], MoviesStoreError?) -> Void)
}

enum MoviesStoreResult<T> {
    case success(result: T)
    case failure(error: MoviesStoreError)
}

enum MoviesStoreError: Swift.Error {
    case cannotFetch(String)
    case cannotUpdate(String)
}

extension NetworkFetcher {
    func fetchNewMovies(_ completion: @escaping ([Movie]) -> Void) {
        self.fetchJSON { (json) in
            do {
                guard let json = json else {
                    return
                }
                
                let result = ResultList.fromJSON(json)
                DispatchQueue.main.async {
                    completion(result.movies ?? [])
                }
            }
        }
    }
    
}


