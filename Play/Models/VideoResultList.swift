//
//  VideoResultList.swift
//  Play
//
//  Created by douglas taquary on 26/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import Foundation
import SwiftyJSON

final public class VideoResultList: NSObject, JSONAbleType {
    
    var id: Int
    var videos: [Video]?
    
    init(id: Int) {
        self.id = id
    }
    
    public static func fromJSON(_ json: [String : Any]) -> VideoResultList {
        let json = JSON(json)
        
        let id = json["id"].intValue
        
        let result = VideoResultList(id: id)
        
        if let videosDict = json["results"].object as? [[String: AnyObject]] {
            result.videos = videosDict.map { Video.fromJSON($0)}
        }
        
        return result
    }
}

