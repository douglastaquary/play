//
//  URLSessionFetcher.swift
//  Play
//
//  Created by resource on 04/04/18.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import UIKit

final class URLSessionFetcher: NetworkFetcher {

    enum DataError: Error {
        case wrongData
    }

    let session: URLSession
    
    init() {
        session = URLSession.shared
    }
    
    func fetchJSON(onComplete: @escaping ((JSONDictionary?) -> Void)) {
        let params = ["Authorization": "Bearer \(AppToken().token ?? "")"]
        if let request = PlayAPI.list(apiKey: AppToken().apiKey ?? "", sort_by: "vote_average.asc", params: params).request {
            self.session.dataTask(with: request) { data, error, response in
                guard let data = data, error == nil else {
                    print("Error: \(String(describing: error))")
                    return onComplete(nil)
                }
                
                guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? JSONDictionary else {
                    return onComplete(nil)
                }
                onComplete(json)
            }.resume()
        }
    }
    
}
