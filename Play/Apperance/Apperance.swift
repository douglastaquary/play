//
//  Apperance.swift
//  Play
//
//  Created by douglas taquary on 18/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import Foundation
import UIKit

struct Apperance {
    
    static func customizeNavigationBar() {
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = UIColor.white
        navigationBarAppearace.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white, NSFontAttributeName: UIFont.systemFont(ofSize: 18, weight: UIFontWeightHeavy)]
    }
    
}
