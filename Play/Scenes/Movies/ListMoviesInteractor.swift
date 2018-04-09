//
//  ListMoviesInteractor.swift
//  Play
//
//  Created by resource on 04/04/18.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import UIKit
import RxSwift

protocol ListMoviesInteractorInput {
    func showMovieList(request: ListMovies.Request)
//    var isLoading: Bool { get }
}

protocol ListMoviesInteractorOutput {
    func presentList(_ reponse: ListMovies.Response)
//    var movies: [Movie]? { get }
}

class ListMoviesInteractor: ListMoviesInteractorInput {

    let disposeBag = DisposeBag()
    var currentLoading = Variable<Bool>(true)
    var output: ListMoviesInteractorOutput?
    var moviesWorker = MoviesWorker()
    
    var isLoading: Bool {
        return currentLoading.value
    }
    
    var movies: [Movie]?
    
    //MARK: - fetch movies
    func fetchMovies(request: ListMovies.Request) {
        moviesWorker.fetchNewMovies().asObservable().subscribe(
            onNext: { [unowned self] newMovies in
                self.movies = newMovies
        }, onError: { error in
            print("\(error.localizedDescription)")
        }).addDisposableTo(disposeBag)
    }
}

extension ListMoviesInteractor {
    func showMovieList(request: ListMovies.Request) {
        let reponse = ListMovies.Response(movies: self.movies ?? [])
        output?.presentList(reponse)
    }
}
