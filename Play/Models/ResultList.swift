//
//  ResultList.swift
//  Play
//
//  Created by douglas taquary on 17/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import Foundation
import SwiftyJSON

final public class ResultList: NSObject, JSONAbleType {
    
    var movies: [Movie]?
    
    override init() {}
    
    public static func fromJSON(_ json: [String : Any]) -> ResultList {
        let json = JSON(json)
        
        let result = ResultList()
        
        if let moviesDict = json["results"].object as? [[String: AnyObject]] {
            result.movies = moviesDict.map { Movie.fromJSON($0)}
        }
        
        return result
    }
}
