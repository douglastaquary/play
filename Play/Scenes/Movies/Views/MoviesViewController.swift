//
//  MoviesViewController.swift
//  Play
//
//  Created by douglas taquary on 17/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import UIKit

protocol MoviesViewControllerProtocol {
    func displayMovies(movies: [Movie])
    func displayError(errorMessage: String)
    func displaySelectedMovie(with movie: Movie)
}

class MoviesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingAcitivity: UIActivityIndicatorView!
    
    var interactor: ListMoviesInteractorProtocol?
    var movies: [Movie] = []
    
    let modalTransitionController = ModalTransition()
    
    public var isLoading = true {
        didSet {
            collectionView.isUserInteractionEnabled = !isLoading
            collectionView.reloadData()
        }
    }
}

extension MoviesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Filmes"
        
        setup()
        
        interactor?.fetchMovies()

        collectionView.backgroundColor = .black
        collectionView.register(cellType: MovieViewCell.self)
        loadingAcitivity.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}


extension MoviesViewController {
    func setup() {
        let interactor = ListMoviesInteractor()
        self.interactor = interactor
        let presenter = ListMoviesPresenter()
        presenter.controller = self
        interactor.presenter = presenter
    }
}


extension MoviesViewController: MoviesViewControllerProtocol {
    func displayMovies(movies: [Movie]) {
        self.movies = movies
        loadingAcitivity.isHidden = true
        self.collectionView.reloadData()
    }
    
    func displayError(errorMessage: String) {
        print(errorMessage)
    }
    
    func displaySelectedMovie(with movie: Movie) {
        let movieDetailViewController = MovieDetailViewController(with: movie)
        movieDetailViewController.delegate = self
        movieDetailViewController.modalPresentationStyle = .custom
        movieDetailViewController.transitioningDelegate = modalTransitionController
        
        self.navigationController?.present(movieDetailViewController,
                                           animated: true)
    }

}


extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MovieViewCell.self)
        let item = movies[indexPath.row]
        cell.setup(item: item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       displaySelectedMovie(with: movies[indexPath.row])
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width - 30
        return MovieViewCell.size(for: width)
    }
    
}

extension MoviesViewController: MovieDetailViewControllerDelegate {
    func didEnd(on viewController: MovieDetailViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
      
}







