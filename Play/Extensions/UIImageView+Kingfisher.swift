//
//  UIImageView+Extensions.swift
//  Play
//
//  Created by douglas taquary on 17/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func download(image url: String){
        if let imageURL = URL(string: url) {
            self.kf.setImage(with: ImageResource(downloadURL: imageURL))
        }
    }
}
