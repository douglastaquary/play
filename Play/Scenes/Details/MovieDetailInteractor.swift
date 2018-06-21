//
//  MovieDetailInteractor.swift
//  Play
//
//  Created by Douglas Taquary on 21/06/18.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import UIKit
import RxSwift

protocol MovieDetailInteractorProtocol {
    func fetchTrailer()
    func didDisplayMovie(with movie: Movie)
}

class MovieDetailInteractor: MovieDetailInteractorProtocol {
    let disposeBag = DisposeBag()
    
    var presenter: MovieDetailPresenterProtocol?
    var moviesWorker = MoviesWorker()
    
    //MARK: - Fetch trailer
    func fetchTrailer() {

    }
    
    func didDisplayMovie(with movie: Movie) {
        self.presenter?.presentMovie(movie)
    }
}
