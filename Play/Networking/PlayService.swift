//
//  PlayService.swift
//  Play
//
//  Created by douglas taquary on 17/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import UIKit

class PlayService: PlayRepository {
    
    let tokenAPI: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5ZGIxZGMwNzQzNDNiODA1Nzg5ZWM0ZDg4NTliY2VmOSIsInN1YiI6IjVhYWM4M2IyYzNhMzY4NDZlNDAwOTdmOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.nMaXy3X7NUBbQJSu_fE7KLXR5eZHeeppnp8KRbru9iw"
    let keyMovies = "9db1dc074343b805789ec4d8859bcef9"
    
    enum DataError: Error {
        case wrongData
    }

    let session: URLSession

    init() {
        session = URLSession.shared
    }
    
    
    // essa é a nossa função que carrega dados da web
    func makeRequest(request: URLRequest, completion: @escaping (Data?) -> Void) {
        session.dataTask(with: request) { data, error, response in
            guard let data = data, error == nil else {
                print("Error: \(String(describing: error))")
                return completion(nil)
            }
            completion(data)
        }.resume()
    }
    
    
}


extension PlayService {
    
    func fetchMovies(_ completion: @escaping ([MovieModel]?) -> Void) {
        let params = ["Authorization": "Bearer \(tokenAPI)"]
        if let request = PlayAPI.list(apiKey: keyMovies, sort_by: "vote_average.asc", params: params).request {
            makeRequest(request: request) { data in
                let jsonDecoder = JSONDecoder()
                do {
                    let result = try jsonDecoder.decode(ResultList.self, from: data ?? Data())
                    let movies: [Movie] = result.movies
                    completion(movies)
                } catch {
                    completion(nil)
                }
            }
        }
    }
    
    func movieDetail(_ withId: Int, completion: @escaping (MovieModel?) -> Void) {
        if let request = PlayAPI.detail(id: withId, apiKey: keyMovies).request {
            makeRequest(request: request) { data in
                let jsonDecoder = JSONDecoder()
                do {
                    let movie = try jsonDecoder.decode(Movie.self, from: data ?? Data())
                    completion(movie)
                } catch {
                    completion(nil)
                }
            }
        }
    }
    
}
