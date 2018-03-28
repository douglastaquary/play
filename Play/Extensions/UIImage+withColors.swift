//
//  UIImage+withColors.swift
//  Play
//
//  Created by douglas taquary on 24/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import UIKit

extension UIImage {
    
    static func image(with color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        let renderer = UIGraphicsImageRenderer(bounds: rect)
        
        let image = renderer.image { _ in
            color.setFill()
            UIRectFill(rect)
        }
        
        return image
    }
}
