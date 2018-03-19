//
//  MovieDetailViewModel.swift
//  Play
//
//  Created by douglas taquary on 17/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import Foundation
import RxSwift

public protocol MovieDetailViewModelType {
    var title: NSAttributedString { get }
    var image: UIImageView { get }
    var nameMovie: NSAttributedString { get }
    var overview: NSAttributedString { get }
    var cancelButtonText: NSAttributedString { get }
    var didTapCancel: () -> Void { get }
    var movie: Movie { get }
}

public struct MovieDetailViewModel: MovieDetailViewModelType {
    public let image: UIImageView
    public let nameMovie: NSAttributedString
    public let overview: NSAttributedString
    public let title: NSAttributedString
    public let cancelButtonText: NSAttributedString
    public let didTapCancel: () -> Void
    public let movie: Movie
}


extension MovieDetailViewModel {
    
    public init() {
        let movie = Movie(id: 0, mediaType: "", voteCount: 0, title: "", posterPath: "", overview: "")
        self.init(movie: movie,
                  didTapCancel: { print("Cancel") })
    }

    public init(movie: Movie,
                didTapCancel: @escaping () -> Void) {
        
        title = NSAttributedString(string: movie.title,
                                   font: UIFont.systemFont(ofSize: 15),
                                   color: UIColor.orange)
        
        cancelButtonText = NSAttributedString(string: "Cancelar",
                                              font: UIFont.systemFont(ofSize: 13),
                                              color: UIColor.lightGray)
        
        image = UIImageView(image: movie.posterImage)
        
        nameMovie = NSAttributedString(string: movie.title,
            font: UIFont.systemFont(ofSize: 22, weight: UIFontWeightBold),
            color: UIColor.white)
        
        overview = NSAttributedString(string: movie.overview,
            font: UIFont.systemFont(ofSize: 15),
            color: UIColor.lightGray)
        
        
        self.movie = Movie(id: movie.id,
                           mediaType: movie.mediaType,
                           voteCount: movie.voteCount,
                           title: movie.title,
                           posterPath:
                           movie.posterPath,
                           overview: movie.overview)
        
        self.didTapCancel = didTapCancel
    }
}
