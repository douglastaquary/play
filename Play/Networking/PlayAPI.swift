//
//  PlayAPI.swift
//  Play
//
//  Created by douglas taquary on 17/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import Foundation

struct ImageBasePath {
    static let url: String = "https://image.tmdb.org/t/p/w500/"
}

enum RequestResult<T> {
    case successo(T)
    case erro(Error)
}

enum PlayAPI {
    
    case list(apiKey: String, sort_by: String, params: [String: Any])
    case detail(id: Int, apiKey: String)
    case ping
    
    var basePath: String {
        return "https://api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .list: return "4/list/1"
        case .detail(let id, _): return "3/movie/\(id)"
        default:
            return "/"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .list(let apiKey, let sort_by, _):
            return ["api_key": apiKey,
                    "sort_by": sort_by,
                    "page": 1]
        case .detail(_, let api_key):
            return ["api_key": api_key]
        default:
            return [:]
        }
    }
    
    var method: String {
        switch self {
        default:
            return "GET"
        }
    }
    
    var body: [String: Any]? {
        switch self {
        case .list(_,_, let bodyParams):
            return bodyParams.count > 0 ? bodyParams : nil
        default:
            return nil
        }
    }
    
    var request: URLRequest? {
        
        let baseUrlPath = "\(basePath)/\(path)"
        var baseURL = URLComponents(string: baseUrlPath)
        
        baseURL?.queryItems = parameters.map { qParamter in
            return URLQueryItem(name: qParamter.key, value: "\(qParamter.value)")
        }
        
        guard let url = baseURL?.url else {
            print("Impossível iniciar request com essa url")
            return nil
        }
        
        var request = URLRequest(url: url)
        
        if let body = self.body {
            if let bodyData = try? JSONSerialization.data(withJSONObject: body, options: []) {
                request.httpBody = bodyData
                request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            }
            
            print("\(url)")
        }
        
        return request
    }
}
