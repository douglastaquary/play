//
//  MoviesViewController.swift
//  Play
//
//  Created by douglas taquary on 17/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import UIKit

protocol MovieDelegate {
    func didSelectMovie(at index: IndexPath)
}


class MoviesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    public var isLoading = true {
        didSet {
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
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .black
        collectionView.register(cellType: MovieViewCell.self)
    }
}

extension MoviesViewController {
    func didSelectMovie(at index: IndexPath) {
        guard let nextController = Storyboard.Main.movieDetailViewControllerScene
            .viewController() as? MovieDetailViewController else {
                return
        }
        
        let movie = viewModel.movies[index.row]
        print("\n\n --> Movie \n\(movie)\n\n")
        self.navigationController?.pushViewController(nextController, animated: true)
    }
}


extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6// : viewModel.movies.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //var cell: UICollectionViewCell!
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MovieViewCell.self)
//        let item = viewModel.movies[indexPath.row]
//        cell.setup(item: item)
        
        return cell
        
//        if isLoading {
//            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ProdutoViewLoadCell.self)
//            return cell
//        }
//        else {
//            
//            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MovieViewCell.self)
//            let item = viewModel.movies[indexPath.row]
//            cell.setup(item: item)
//            
//            return cell
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.didSelectMovie(at: indexPath)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width - 30
        return MovieViewCell.size(for: width)
    }
    
}
