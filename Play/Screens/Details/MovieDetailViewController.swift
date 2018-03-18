//
//  MovieDetailViewController.swift
//  Play
//
//  Created by douglas taquary on 17/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import UIKit

protocol MovieDetailViewControllerDelegate {
    func didEnd(on viewController: MovieDetailViewController)
}

class MovieDetailViewController: UIViewController {
    let movie: Movie
    public var delegate: MovieDetailViewControllerDelegate?
    
    public required init(with movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieDetailViewController {
    
    var theView: MovieDetailView {
        // I don't like this `!` but it's a framework limitation
        return self.view as! MovieDetailView
    }
    
    override public func loadView() {
        // To avoid warnings of autolayout while the view
        // is not resized by the system
        let frame = UIScreen.main.bounds
        let view = MovieDetailView(frame: frame)
        self.view = view
    }
}


extension MovieDetailViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let viewModel = MovieDetailViewModel(movie: movie,
                                             didTapCancel: { [weak self] in self?.didEnd() })
        
        theView.viewModel = viewModel
    }
    
    override public func viewDidLayoutSubviews() {
        theView.topOffset = topLayoutGuide.length
    }
    
}

extension MovieDetailViewController {
    func didEnd() {
        delegate?.didEnd(on: self)
    }
}
