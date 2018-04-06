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
    var didLoaded: Bool { get }
    var videos: [Video] { get }
    var title: NSAttributedString { get }
    var nameMovie: NSAttributedString { get }
    var imagePath: String { get }
    var overview: NSAttributedString { get }
    var cancelButtonText: NSAttributedString { get }
    var didTapCancel: () -> Void { get }
    var didTapWatchTrailer: () -> Void { get }
    var movie: Movie { get }
    
    func fetchTrailerByVideo(with id: Int) -> Observable<Void>
}

public struct MovieDetailViewModel: MovieDetailViewModelType {
    let disposeBag = DisposeBag()
    
    let provider: Networking = Networking.newDefaultNetworking()
    
    public let imagePath: String
    public let nameMovie: NSAttributedString
    public let overview: NSAttributedString
    public let title: NSAttributedString
    public let cancelButtonText: NSAttributedString
    public let didTapCancel: () -> Void
    public let didTapWatchTrailer: () -> Void
    public let movie: Movie
    
    public var rxdidLoaded = Variable<Bool>(false)
    public var didLoaded: Bool {
        return rxdidLoaded.value
    }
    
    fileprivate var currentVideos = Variable<Array<Video>>([])
    public var videos: [Video] {
        return currentVideos.value
    }
}


extension MovieDetailViewModel: VideoServiceProtocol {
    public func fetchTrailerByVideo(with id: Int) -> Observable<Void> {
        let endpoint = PlayAPI.video(id: id, apiKey: AppToken().apiKey ?? "")
        
        return provider.request(endpoint)
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .mapTo(object: VideoResultList.self)
            .map { result in
                self.currentVideos.value = result.videos ?? []
            }
            .map(void)
    }
    
}


extension MovieDetailViewModel {
    
    public init() {
        let movie = Movie(id: 0, mediaType: "", voteCount: 0, title: "", posterPath: "/path", overview: "")
        self.init(movie: movie,
                  didTapCancel: { print("Cancel") },
                  didTapWatchTrailer: { print("") })
    }

    public init(movie: Movie,
                didTapCancel: @escaping () -> Void,
                didTapWatchTrailer: @escaping () -> Void){
        
        title = NSAttributedString(string: movie.title,
                                   font: UIFont.systemFont(ofSize: 15),
                                   color: UIColor.orange)
        
        cancelButtonText = NSAttributedString(string: "Voltar",
                                              font: UIFont.systemFont(ofSize: 14),
                                              color: UIColor.lightGray)
        
        imagePath = "\(ImageBasePath.url)\(movie.posterPath)"
        
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
                           posterPath: "\(ImageBasePath.url)\(movie.posterPath)",
                           overview: movie.overview)
        
        self.didTapCancel = didTapCancel
        self.didTapWatchTrailer = didTapWatchTrailer
    
    }
}
