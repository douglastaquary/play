//
//  VideoServiceProtocol.swift
//  Play
//
//  Created by douglas taquary on 24/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import Foundation
import RxSwift

protocol VideoServiceProtocol {
    func fetchTrailerByVideo(with id: Int) -> Observable<Void>
}
