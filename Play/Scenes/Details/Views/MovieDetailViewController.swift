//
//  MovieDetailViewController.swift
//  Play
//
//  Created by douglas taquary on 17/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import UIKit
import RxSwift

protocol MovieDetailViewControllerProtocol {
    func displayMovie(_ movie: Movie)
    func displayError(errorMessage: String)
    func displayMovieTrailer(with movie: Movie)
}


class MovieDetailViewController: UIViewController {
    
    var movie: Movie
    var video: Video? = nil
    
    var interactor: MovieDetailInteractorProtocol?
    
    var detailView = MovieDetailView()
    var didLoaded = Variable<Bool>(false)
    
    let disposeBagUI = DisposeBag()
    
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
        detailView = MovieDetailView(frame: frame)
        let view = detailView
        self.view = view
    }
}


extension MovieDetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        interactor?.didDisplayMovie(with: self.movie)
        
        theView.didEnd = { [weak self] in
            self?.didEnd()
        }
    }

    override public func viewDidLayoutSubviews() {
        theView.topOffset = topLayoutGuide.length
    }
    
    func setupView() {
        let interactor = MovieDetailInteractor()
        self.interactor = interactor
        let presenter = MovieDetailPresenter()
        presenter.controller = self
        interactor.presenter = presenter
    }
    
    func didEnd() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func playTrailer() {
        if let video = video {
            PlaybackHelper(with: video).play(from: self)
        }
        print("Playiou")
    }

}

extension MovieDetailViewController: MovieDetailViewControllerProtocol {
    func displayMovie(_ movie: Movie) {
        theView.updateView(with: movie)
    }
    
    func displayError(errorMessage: String) {
        print("\n### TODO: - Implement alert error")
    }
    
    func displayMovieTrailer(with movie: Movie) {
        print("did tap show ")
    }
}
