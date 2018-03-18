//
//  HelperFunctions.swift
//  Play
//
//  Created by douglas taquary on 17/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import Foundation

// Useful for mapping an Observable<Whatever> into an Observable<Void> to hide details.
func void<T>(_: T) -> Void {
    return Void()
}
