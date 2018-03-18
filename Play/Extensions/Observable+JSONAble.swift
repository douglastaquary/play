//
//  Observable+JSONAble.swift
//  Play
//
//  Created by douglas taquary on 17/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import Foundation
import Moya
import RxSwift

enum PlayError: String {
    case couldNotParseJSON
    case notLoggedIn
    case missingData
}

extension PlayError: Swift.Error { }

extension Observable {
    
    typealias Dictionary = [String: AnyObject]
    
    /// Get given JSONified data, pass back objects
    func mapTo<B: JSONAbleType>(object classType: B.Type) -> Observable<B> {
        return self.map { json in
            guard let dict = json as? Dictionary else {
                throw PlayError.couldNotParseJSON
            }
            
            return B.fromJSON(dict)
        }
    }
    
    /// Get given JSONified data, pass back objects as an array
    func mapTo<B: JSONAbleType>(arrayOf classType: B.Type) -> Observable<[B]> {
        return self.map { json in
            guard let array = json as? [AnyObject] else {
                throw PlayError.couldNotParseJSON
            }
            
            guard let dicts = array as? [Dictionary] else {
                throw PlayError.couldNotParseJSON
            }
            
            return dicts.map { B.fromJSON($0) }
        }
    }
    
}

