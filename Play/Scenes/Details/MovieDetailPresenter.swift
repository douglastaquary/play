//
//  MovieDetailPresenter.swift
//  Play
//
//  Created by Douglas Taquary on 21/06/18.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import UIKit

protocol MovieDetailPresenterProtocol {
    func presentMovie(_ movie: Movie)
    func presentError(errorMessage: String)
}

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    //MARK: Properties
    var controller: MovieDetailViewControllerProtocol?
    
    //MARK: Presenter Protocol
    func presentMovie(_ movie: Movie) {
        controller?.displayMovie(movie)
    }

    func presentError(errorMessage: String) {
        controller?.displayError(errorMessage: errorMessage)
    }
    
}
