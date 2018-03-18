//
//  SnapshotService.swift
//  PlayTests
//
//  Created by douglas taquary on 18/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import Foundation
import Nimble
import Nimble_Snapshots

public struct SnapshotService {
    public init(forceRecord: Bool = false) {
        self.forceRecord = forceRecord
    }
    
    let forceRecord: Bool
    
    public func haveSnapshot(named: String? = nil,
                             sizes: [String: CGSize]? = nil,
                             usesDrawRect: Bool = false,
                             tolerance: CGFloat? = nil) -> Nimble.Predicate<Snapshotable> {
        if forceRecord {
            return recordSnapshot(named: named, sizes: sizes, usesDrawRect: usesDrawRect)
        } else if let sizes = sizes {
            return haveValidDynamicSizeSnapshot(named: named,
                                                sizes: sizes,
                                                isDeviceAgnostic: true,
                                                usesDrawRect: usesDrawRect,
                                                tolerance: tolerance,
                                                resizeMode: .frame)
        } else {
            return haveValidDeviceAgnosticSnapshot(named: named, usesDrawRect: usesDrawRect, tolerance: tolerance)
        }
    }
    
    public func recordSnapshot(named: String? = nil,
                               sizes: [String: CGSize]? = nil,
                               usesDrawRect: Bool = false) -> Nimble.Predicate<Snapshotable> {
        if let sizes = sizes {
            return recordDynamicSizeSnapshot(named: named,
                                             sizes: sizes,
                                             isDeviceAgnostic: true,
                                             usesDrawRect: usesDrawRect,
                                             resizeMode: .frame)
        } else {
            return recordDeviceAgnosticSnapshot(named: named, usesDrawRect: usesDrawRect)
        }
    }
}
