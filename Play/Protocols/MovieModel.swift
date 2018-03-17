//
//  MovieModel.swift
//  Play
//
//  Created by douglas taquary on 17/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import Foundation

protocol MovieModel {
    var id: Int { get }
    var mediaType: String { get }
    var voteCount: Int { get }
    var title: String { get }
    var posterPath: String { get }
    var overview: String { get }
    //var releaseDate: Date { get }
}
