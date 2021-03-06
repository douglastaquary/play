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
    var nameMovie: NSAttributedString { get }
    var imagePath: String { get }
    var overview: NSAttributedString { get }
    var cancelButtonText: NSAttributedString { get }
    var didTapCancel: () -> Void { get }
    var movie: Movie { get }
}

public struct MovieDetailViewModel: MovieDetailViewModelType {
    public let imagePath: String
    public let nameMovie: NSAttributedString
    public let overview: NSAttributedString
    public let title: NSAttributedString
    public let cancelButtonText: NSAttributedString
    public let didTapCancel: () -> Void
    public let movie: Movie
}


extension MovieDetailViewModel {
    
    public init() {
        let movie = Movie(id: 0, mediaType: "", voteCount: 0, title: "", posterPath: "/path", overview: "")
        self.init(movie: movie,
                  didTapCancel: { print("Cancel") })
    }

    public init(movie: Movie,
                didTapCancel: @escaping () -> Void) {
        
        title = NSAttributedString(string: movie.title,
                                   font: UIFont.systemFont(ofSize: 15),
                                   color: UIColor.orange)
        
        cancelButtonText = NSAttributedString(string: "Cancelar",
                                              font: UIFont.systemFont(ofSize: 15),
                                              color: UIColor.lightGray)
        
        imagePath = "\(ImageBasePath.url)\(movie.posterPath)"
        
        nameMovie = NSAttributedString(string: movie.title,
            font: UIFont.systemFont(ofSize: 22, weight: UIFontWeightBold),
            color: UIColor.white)
        
        overview = NSAttributedString(string: movie.overview,
            font: UIFont.systemFont(ofSize: 18),
            color: UIColor.lightGray)
        
        
        self.movie = Movie(id: movie.id,
                           mediaType: movie.mediaType,
                           voteCount: movie.voteCount,
                           title: movie.title,
                           posterPath: "\(ImageBasePath.url)\(movie.posterPath)",
                           overview: movie.overview)
        
        self.didTapCancel = didTapCancel
    }
}
