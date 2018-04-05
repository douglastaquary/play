//
//  AppToken.swift
//  Play
//
//  Created by douglas taquary on 19/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import Foundation

struct AppToken {
    enum DefaultsKeys: String {
        case ApiKey = "ApiKey"
        case TokenKey = "TokenKey"
    }
    
    // MARK: - Initializers
    let defaults: UserDefaults
    
    init(defaults: UserDefaults) {
        self.defaults = defaults
    }
    
    init() {
        self.defaults = UserDefaults.standard
    }
    
    // MARK: - Properties
    var token: String? {
        get {
            let token = defaults.string(forKey: DefaultsKeys.TokenKey.rawValue)
            return token
        }
        set(newToken) {
            defaults.set(newToken, forKey: DefaultsKeys.TokenKey.rawValue)
        }
    }
    
    var apiKey: String? {
        get {
            let key = defaults.string(forKey: DefaultsKeys.ApiKey.rawValue)
            return key
        }
        set(newApiKey) {
            defaults.set(newApiKey, forKey: DefaultsKeys.ApiKey.rawValue)
        }
    }

}
