//
//  UserDefaults+Extensions.swift
//  Play
//
//  Created by douglas taquary on 22/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    private struct Keys {
        static let positionSufix = "-position"
        
        static func position(in video: Int) -> String {
            return "\(video)\(positionSufix)"
        }
    }
    
    func position(in video: Int) -> Float {
        return UserDefaults.standard.float(forKey: Keys.position(in: video))
    }
    
    func set(position: Float, in video: Int) {
        UserDefaults.standard.setValue(position, forKey: Keys.position(in: video))
    }
    
}
