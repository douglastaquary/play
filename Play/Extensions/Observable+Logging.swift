//
//  Observable+Logging.swift
//  Play
//
//  Created by douglas taquary on 17/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import RxSwift

extension Observable {
    func logError(prefix: String = "Error: ") -> Observable<Element> {
        return self.do(onError: { error in
            print("\(prefix)\(error)")
        })
    }
    
    func logServerError(message: String) -> Observable<Element> {
        return self.do(onError: { e in
            let error = e as NSError
            print(message)
            print("Error: \(error.localizedDescription))")
        })
    }
    
    func logNext() -> Observable<Element> {
        return self.do(onNext: { element in
            print("\(element)")
        })
    }
}
