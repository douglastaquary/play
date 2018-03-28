//
//  Video.swift
//  Play
//
//  Created by douglas taquary on 22/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import Foundation
import SwiftyJSON

enum DisplayType: String {
    case trailer = "Trailer"
    case clip = "Clip"
}

final public class Video: NSObject, JSONAbleType {
    
    var id: String
    var iso_639_1: String
    var iso_3166_1: String
    var key: String
    var name: String
    var site: String
    var size: Int
    var type: DisplayType
    
    init(id: String, iso_639_1: String, iso_3166_1: String, key: String, name: String, site: String, size: Int, type: DisplayType) {
        self.id = id
        self.iso_639_1 = iso_639_1
        self.iso_3166_1 = iso_3166_1
        self.key = key
        self.name = name
        self.site = site
        self.size = size
        self.type = type
    }
    
    public static func fromJSON(_ json: [String : Any]) -> Video {
        let json = JSON(json)
        
        let id = json["id"].stringValue
        let iso_639_1 = json["iso_639_1"].stringValue
        let iso_3166_1 = json["iso_3166_1"].stringValue
        let key = json["key"].stringValue
        let name = json["name"].stringValue
        let site = json["site"].stringValue
        let size = json["size"].intValue
        let type = json["type"].stringValue
        
        let video = Video(id: id,
                          iso_639_1: iso_639_1,
                          iso_3166_1: iso_3166_1,
                          key: key, name: name,
                          site: site,
                          size: size,
                          type: DisplayType.init(rawValue: type) ?? DisplayType.trailer)
        
        return video
    }
}
