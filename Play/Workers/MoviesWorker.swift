//
//  MoviesWorker.swift
//  Play
//
//  Created by resource on 04/04/18.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import UIKit
import Foundation
import RxSwift

//MARK: - MoviesWorker

typealias FetchResult = () -> Void
typealias JSONDictionary = [String:Any]

fileprivate let provider: Networking = Networking.newDefaultNetworking()

private let sort_by_vote_average_asc = "vote_average.asc"

struct MoviesWorker: NetworkFetcher {
    
    init() {}
    
    func fetchNewMovies() -> Observable<Array<Movie>> {
        let endpoint: PlayAPI = PlayAPI.list(apiKey: AppToken().apiKey ?? "", sort_by: sort_by_vote_average_asc)
        
        return provider.request(endpoint)
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .mapTo(object: ResultList.self)
            .map { result -> [Movie] in
                return result.movies ?? []
            }
    }

}

protocol NetworkFetcher {
    func fetchNewMovies() -> Observable<Array<Movie>>
}

enum MoviesStoreResult<T> {
    case success(result: T)
    case failure(error: MoviesStoreError)
}

enum MoviesStoreError: Swift.Error {
    case cannotFetch(String)
    case cannotUpdate(String)
}


