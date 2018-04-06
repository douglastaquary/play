//
//  PlayRepository.swift
//  Play
//
//  Created by douglas taquary on 17/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import Foundation
import RxSwift

protocol PlayRepository {
    func fetchMovies() -> Observable<Void>
}
