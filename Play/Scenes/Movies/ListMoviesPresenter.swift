//
//  ListMoviesPresenter.swift
//  Play
//
//  Created by resource on 05/04/18.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import UIKit

protocol ListMoviesPresenterOutput: class {
    func displayList(_ viewModel: ListMovies.ViewModel)
}

class ListMoviesPresenter: ListMoviesInteractorOutput {
    weak var output: ListMoviesPresenterOutput?
    
    //MARK: - Fetch Movies
    func presentList(_ reponse: ListMovies.Response) {
        var displayedMovies: [ListMovies.ViewModel.DisplayedMovie] = []
        
        reponse.movies.forEach { (movie) in
            let displayedMovie =
                    ListMovies.ViewModel.DisplayedMovie(id: movie.id,
                                                        mediaType: movie.mediaType,
                                                        voteCount: movie.voteCount,
                                                        title: movie.title,
                                                        posterPath: movie.posterPath,
                                                        overview: movie.overview)
            displayedMovies.append(displayedMovie)
        }

        let viewModel = ListMovies.ViewModel(displayedMovies: displayedMovies)
        output?.displayList(viewModel)
    }
        
}
