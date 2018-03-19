//
//  PlayRepositoryMock.swift
//  PlayTests
//
//  Created by douglas taquary on 18/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import Foundation
import RxSwift

@testable import Play

class PlayRepositoryMock: PlayRepository {
    
    var moviesResponse:[Movie]?
    
    func fetchMovies() -> Observable<Void> {
        return Observable.just(())
    }
    
}
