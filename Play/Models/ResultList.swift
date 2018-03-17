//
//  ResultList.swift
//  Play
//
//  Created by douglas taquary on 17/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import Foundation

struct ResultList: ResponseListModel, Codable {
    var movies: [Movie]

    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        movies = try values.decode([Movie].self, forKey: .movies)
    }
}

