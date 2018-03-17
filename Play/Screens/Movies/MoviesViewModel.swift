//
//  MoviesViewModel.swift
//  Play
//
//  Created by douglas taquary on 17/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import Foundation

protocol MoviesViewModelType {
    var movies: [MovieModel] { get }
}


class MoviesViewModel: MoviesViewModelType {
    
    let playService: PlayService = PlayService()
    var currentMovies: [MovieModel] = []
    var movies: [MovieModel] {
        return currentMovies
    }
    
    init() {
        getMovies()
    }
    
    fileprivate func getMovies() {
        playService.fetchMovies { movies in
            self.currentMovies = movies ?? []
        }
    }
}
