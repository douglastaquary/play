//
//  ListMoviesPresenter.swift
//  Play
//
//  Created by resource on 05/04/18.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import UIKit

protocol ListMoviesPresenterProtocol {
    func presentMoviesList(_ movies: [Movie])
    func presentSelectedMovie(movie: Movie)
    func presentError(errorMessage: String)
}

class ListMoviesPresenter: ListMoviesPresenterProtocol {

    //MARK: Properties
    var controller: MoviesViewControllerProtocol?
    
    //MARK: Presenter Protocol
    func presentMoviesList(_ movies: [Movie]) {
        controller?.displayMovies(movies: movies)
    }
    
    func presentSelectedMovie(movie: Movie) {
        controller?.displaySelectedMovie(with: movie)
    }
    
    func presentError(errorMessage: String) {
        controller?.displayError(errorMessage: errorMessage)
    }
        
}
