//
//  MoviesViewController.swift
//  Play
//
//  Created by douglas taquary on 17/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import UIKit

protocol ListMoviesDisplayLogic: class {
    func displayFetchMovies(viewModel: ListMovies.ViewModel)
}

class MoviesViewController: UIViewController, ListMoviesPresenterOutput {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingAcitivity: UIActivityIndicatorView!
    
    var output: ListMoviesInteractorInput?
    var router: (NSObjectProtocol & ListMoviesRouterLogic & ListMoviesDataPassing)?
    
    var displayedMovies: [ListMovies.ViewModel.DisplayedMovie] = []

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
        
        ListMoviesConfigurator.sharedInstance.configure(viewController: self)

        collectionView.backgroundColor = .black
        collectionView.register(cellType: MovieViewCell.self)
        loadingAcitivity.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showListOnLoad()
    }
}


extension MoviesViewController {
    func showListOnLoad() {
        output?.showMovieList(request: ListMovies.Request())
    }
}

extension MoviesViewController {
    func displayList(_ viewModel: ListMovies.ViewModel) {
        displayedMovies = viewModel.displayedMovies
        collectionView.reloadData()
    }
}

extension MoviesViewController {
    func displayFetchMovies(viewModel: ListMovies.ViewModel) {
        displayedMovies = viewModel.displayedMovies
        collectionView.reloadData()
    }
}

extension MoviesViewController {
    func updateMovies()  {
        loadingAcitivity.isHidden = false
        loadingAcitivity.startAnimating()
    }
}


extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MovieViewCell.self)
        let item = displayedMovies[indexPath.row]
        cell.setup(item: item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // router.routerToShowMovie(at: )
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







