//
//  PlayAPI.swift
//  Play
//
//  Created by douglas taquary on 17/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//



import Foundation
import RxSwift
import Moya
import Alamofire

struct ImageBasePath {
    static let url: String = "https://image.tmdb.org/t/p/w500/"
}


enum PlayAPI {
    case list(apiKey: String, sort_by: String)
    case detail(id: Int, apiKey: String)
    case ping
}


extension PlayAPI: TargetType {

    var task: Task {
        switch self {
        default:
            return .request
        }
    }

    var base: String { return "https://api.themoviedb.org" }
    var baseURL: URL { return URL(string: base)! }

    var path: String {
        switch self {
        case .list: return "4/list/1"
        case .detail(let id, _): return "3/movie/\(id)"
        default:
            return "/"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .list(let apiKey, let sort_by):
            return ["api_key": apiKey,
                    "sort_by": sort_by,
                    "page": 1]
        case .detail(_, let api_key):
            return ["api_key": api_key]
        default:
            return [:]
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var parameterEncoding: Moya.ParameterEncoding {
        switch self {
        default:
            return URLEncoding.default
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    
    var sampleData: Data {
        switch self {
        default:
            return Data()
        }
    }
}


// MARK: Provider Support
private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}

func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}


