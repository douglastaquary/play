//
//  JSONAbleType.swift
//  Play
//
//  Created by douglas taquary on 17/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import Foundation

protocol JSONAbleType {
    static func fromJSON(_: [String: Any]) -> Self
}
