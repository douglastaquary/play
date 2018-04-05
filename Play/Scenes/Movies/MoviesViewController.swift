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

class MoviesViewController: UIViewController, ListMoviesDisplayLogic {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingAcitivity: UIActivityIndicatorView!
    
    var interactor: ListMoviesBusinessLogic?
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
        collectionView.backgroundColor = .black
        collectionView.register(cellType: MovieViewCell.self)
        loadingAcitivity.startAnimating()
        setup()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchMovies()
    }
}


extension MoviesViewController {
    //MARK: - Setup
    fileprivate func setup() {
        let viewController = self
        let interactor = ListMoviesInteractor()
        let presenter = ListMoviesPresenter()
        let router = ListMoviesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
}

extension MoviesViewController {
    func fetchMovies() {
        let request = ListMovies.Request()
        interactor?.fetchMovies(request: request)
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







