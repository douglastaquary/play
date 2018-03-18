//
//  Movie.swift
//  Play
//
//  Created by douglas taquary on 17/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import Foundation
import SwiftyJSON

final public class Movie: NSObject, JSONAbleType {

    var id: Int
    var mediaType: String
    var voteCount: Int
    var title: String
    var posterPath: String
    var overview: String
    var posterImage: UIImage?
    // var releaseDate: Date

    init(id: Int, mediaType: String, voteCount: Int, title: String, posterPath: String, overview: String) {
        self.id = id
        self.mediaType = mediaType
        self.voteCount = voteCount
        self.title = title
        self.posterPath = posterPath
        self.overview = overview
    }

    public static func fromJSON(_ json: [String : Any]) -> Movie {
        let json = JSON(json)

        let id = json["id"].intValue
        let mediaType = json["media_type"].stringValue
        let voteCount = json["vote_count"].intValue
        let title = json["title"].stringValue
        let posterPath = json["poster_path"].stringValue
        let overview = json["overview"].stringValue

        let movie = Movie(id: id, mediaType: mediaType, voteCount: voteCount, title: title, posterPath: posterPath, overview: overview)

        return movie
    }
}

