//
//  ListMoviesPresenter.swift
//  Play
//
//  Created by resource on 05/04/18.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import UIKit

protocol ListMoviesPresentationLogic {
    func presentFetchMovies(response: ListMovies.Response)
}

class ListMoviesPresenter: ListMoviesPresentationLogic {
    weak var viewController: ListMoviesDisplayLogic?
    
    //MARK: - Fetch Movies
    func presentFetchMovies(response: ListMovies.Response) {
        var displayedMovies: [ListMovies.ViewModel.DisplayedMovie] = []
        for movie in response.movies {
            let id = movie.id
            let mediaType = movie.mediaType
            let voteCount = movie.voteCount
            let title = movie.title
            let posterPath = movie.posterPath
            let overview = movie.posterPath
            let displayedMovie = ListMovies.ViewModel.DisplayedMovie(id: id, mediaType: mediaType, voteCount: voteCount, title: title, posterPath: posterPath, overview: overview)
            displayedMovies.append(displayedMovie)
        }
        
        let viewModel = ListMovies.ViewModel(displayedMovies: displayedMovies)
        viewController?.displayFetchMovies(viewModel: viewModel)
    }
        
}
