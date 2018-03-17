//
//  Movie.swift
//  Play
//
//  Created by douglas taquary on 17/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import Foundation

struct Movie: MovieModel, Codable {
    var id: Int
    var mediaType: String
    var voteCount: Int
    var title: String
    var posterPath: String
    var overview: String
   // var releaseDate: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case mediaType = "media_type"
        case voteCount = "vote_count"
        case title
        case posterPath = "poster_path"
        case overview
       // case releaseDate = "release_date"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        mediaType = try values.decode(String.self, forKey: .mediaType)
        voteCount = try values.decode(Int.self, forKey: .voteCount)
        title = try values.decode(String.self, forKey: .title)
        posterPath = try values.decode(String.self, forKey: .posterPath)
        overview = try values.decode(String.self, forKey: .posterPath)
 //       let rawDate = try values.decode(String.self, forKey: .releaseDate)
 

    }
}
