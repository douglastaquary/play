//
//  MoviesViewModel.swift
//  Play
//
//  Created by douglas taquary on 17/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import Foundation
import RxSwift

protocol MoviesViewModelType {
    var movies: [Movie] { get }
    func fetchMovies() -> Observable<Void>
}

class MoviesViewModel: MoviesViewModelType, PlayRepository {
    
    let provider: Networking = Networking.newDefaultNetworking()
    fileprivate var currentMovies = Variable<Array<Movie>>([])
    var movies: [Movie] {
        return currentMovies.value
    }
    
    init() {}
    
    func fetchMovies() -> Observable<Void> {
        let endpoint: PlayAPI = PlayAPI.list(apiKey: AppToken().apiKey ?? "", sort_by: "vote_average.asc")
        
        return provider.request(endpoint)
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .mapTo(object: ResultList.self)
            .map { result in
                self.currentMovies.value = result.movies ?? []
            }.map(void)
    }
}
