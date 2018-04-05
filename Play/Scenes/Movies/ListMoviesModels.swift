//
//  ListMovies.swift
//  Play
//
//  Created by resource on 04/04/18.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import UIKit

enum ListMovies {
    struct Request {}
    
    struct Response {
        var movies: [Movie]
    }
    
    struct ViewModel {
        struct DisplayedMovie {
            var id: Int
            var mediaType: String
            var voteCount: Int
            var title: String
            var posterPath: String
            var overview: String
        }
        
        var displayedMovies: [DisplayedMovie]
    }
}

