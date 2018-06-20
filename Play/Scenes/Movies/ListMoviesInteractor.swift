//
//  ListMoviesInteractor.swift
//  Play
//
//  Created by resource on 04/04/18.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import UIKit
import RxSwift

protocol ListMoviesInteractorProtocol {
    func fetchMovies()
    func didSelectedMovie(with movie: Movie)
}

class ListMoviesInteractor: ListMoviesInteractorProtocol {
    
    let disposeBag = DisposeBag()
    var currentLoading = Variable<Bool>(true)
    
    var presenter: ListMoviesPresenterProtocol?
    var moviesWorker = MoviesWorker()
    
    var isLoading: Bool {
        return currentLoading.value
    }

    //MARK: - fetch movies
    func fetchMovies() {
        moviesWorker.fetchNewMovies().asObservable().subscribe(
            onNext: { [unowned self] newMovies in
                self.presenter?.presentMoviesList(newMovies)
        }, onError: { error in
            self.presenter?.presentError(errorMessage: error.localizedDescription)
        }).addDisposableTo(disposeBag)
    }
    
    func didSelectedMovie(with movie: Movie) {
        self.presenter?.presentSelectedMovie(movie: movie)
    }
}


