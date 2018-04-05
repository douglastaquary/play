//
//  ListMoviesRouter.swift
//  Play
//
//  Created by resource on 05/04/18.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import UIKit

@objc protocol ListMoviesRouterLogic {
    func routerToShowMovie(at controller: UIViewController)
}

protocol ListMoviesDataPassing {
    var dataStore: ListMoviesData? { get }
}

class ListMoviesRouter: NSObject, ListMoviesRouterLogic, ListMoviesDataPassing {
    weak var viewController: MoviesViewController?
    var dataStore: ListMoviesData?
    
    let modalTransitionController = ModalTransition()
    
    //MARK: - Routing
    func routerToShowMovie(at controller: UIViewController) {
        if let vc = controller as? MovieDetailViewController {
//            var destination = vc.router.dataStore
//            passDataToShowMovie(source: dataStore!, destination: &destination)
        }
        
    }
    
    //MARK: - Navigation
    func navigateToShowMovie(source: MoviesViewController, destination: MovieDetailViewController) {
        destination.modalPresentationStyle = .custom
        destination.transitioningDelegate = modalTransitionController
        source.present(destination, animated: true, completion: nil)
    }
    
    //MARK: - Passing Data
    func passDataToShowMovie(source: ListMoviesData, destination: inout MovieDetailViewController) {
        if let selectedRows = viewController?.collectionView.indexPathsForSelectedItems {
            guard let selectedIndex = selectedRows.first else {
                return
            }
            destination.movie = source.movies![selectedIndex.row]
        }
    }
}

