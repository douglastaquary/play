//
//  Networking.swift
//  Play
//
//  Created by douglas taquary on 17/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Alamofire


class OnlineProvider<Target>: RxMoyaProvider<Target> where Target: TargetType {
    
    init(endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
         plugins: [PluginType] = []) {
        super.init(endpointClosure: endpointClosure, plugins: plugins)
    }
}


protocol NetworkingType {
    associatedtype T: TargetType
    var provider: OnlineProvider<PlayAPI> { get }
}


struct Networking: NetworkingType {
    typealias T = PlayAPI
    let provider: OnlineProvider<PlayAPI>
}


extension Networking {
    func request(_ token: PlayAPI) -> Observable<Moya.Response> {
        return self.provider.request(token)
    }
}

extension NetworkingType {
    static func newDefaultNetworking() -> Networking {
        return Networking(provider: newProvider([NetworkLoggerPlugin(verbose: false)]))
    }
    
    static func endpointsClosure<T>() -> (T) -> Endpoint<T> where T: TargetType {
        return { target in
            var endpoint: Endpoint<T> = Endpoint<T>(url: url(target), sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters, parameterEncoding: target.parameterEncoding)

            let tokenAPI: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5ZGIxZGMwNzQzNDNiODA1Nzg5ZWM0ZDg4NTliY2VmOSIsInN1YiI6IjVhYWM4M2IyYzNhMzY4NDZlNDAwOTdmOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.nMaXy3X7NUBbQJSu_fE7KLXR5eZHeeppnp8KRbru9iw"
            
            endpoint = endpoint.adding(newHTTPHeaderFields: ["Authorization": "Bearer \(tokenAPI)"])

            
            return endpoint
        }
    }
}


private func newProvider<T>(_ plugins: [PluginType]) -> OnlineProvider<T> where T: TargetType {
    return OnlineProvider(endpointClosure: Networking.endpointsClosure(), plugins: plugins)
}

