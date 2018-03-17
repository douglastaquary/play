//
//  PlayRepository.swift
//  Play
//
//  Created by douglas taquary on 17/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import Foundation

protocol PlayRepository {
    func fetchMovies(_ completion: @escaping (_ results: [MovieModel]?) -> Void)
    func movieDetail(_ withId: Int, completion: @escaping (_ movie: MovieModel?) -> Void)
}
