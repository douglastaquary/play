//
//  MoviesViewController.swift
//  Play
//
//  Created by douglas taquary on 17/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import UIKit
import RxSwift

protocol MovieDelegate {
    func didSelectMovie(at index: IndexPath)
}

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingAcitivity: UIActivityIndicatorView!
    
    var movies: [Movie] = []
    
    let modalTransitionController = ModalTransition()
    
    let disposeBagUI = DisposeBag()
    public var isLoading = true {
        didSet {
            loadingAcitivity.startAnimating()
            collectionView.isUserInteractionEnabled = !isLoading
            collectionView.reloadData()
        }
    }
    
    var viewModel: MoviesViewModelType = MoviesViewModel() {
        didSet {
            collectionView.reloadData()
        }
    }

}

extension MoviesViewController {
    func setupCollectionView(with movies: [Movie]){
        self.movies = movies
        collectionView.reloadData()
    }
}

extension MoviesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Filmes"
        
        collectionView.backgroundColor = .black
        collectionView.register(cellType: MovieViewCell.self)
        
        viewModel.fetchMovies().asObservable()
            .subscribe(onNext: {[weak self] _ in
                guard let me = self else { return }
                
                me.loadingAcitivity.isHidden = me.isLoading
                me.setupCollectionView(with: me.viewModel.movies)
                
            }, onError: { error in
                self.loadingAcitivity.isHidden = self.isLoading
                print("Mostrar um ALERTA")
            })
            .addDisposableTo(disposeBagUI)
    }
}

extension MoviesViewController {
    func didSelectMovie(at index: IndexPath) {
        let movie = movies[index.row]
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
        //var cell: UICollectionViewCell!
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MovieViewCell.self)
        let item = movies[indexPath.row]
        cell.setup(item: item)
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.didSelectMovie(at: indexPath)
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






