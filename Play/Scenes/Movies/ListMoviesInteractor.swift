//
//  ListMoviesInteractor.swift
//  Play
//
//  Created by resource on 04/04/18.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import UIKit

protocol ListMoviesBusinessLogic {
    func fetchMovies(request: ListMovies.Request)
}

protocol ListMoviesData {
    var movies: [Movie]? { get }
}

class ListMoviesInteractor: ListMoviesBusinessLogic, ListMoviesData {
    var presenter: ListMoviesPresentationLogic?
    var moviesWorker = MoviesWorker(networkFetcher: URLSessionFetcher.init())
    
    var movies: [Movie]?
    
    //MARK: - fetch movies
    func fetchMovies(request: ListMovies.Request) {
        moviesWorker.networkFetcher.fetchNewMovies { (movies) -> Void in
            self.movies = movies
            let response = ListMovies.Response(movies: movies)
            self.presenter?.presentFetchMovies(response: response)
        }
    }
}
