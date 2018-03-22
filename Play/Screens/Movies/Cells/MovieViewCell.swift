//
//  MovieViewCell.swift
//  Play
//
//  Created by douglas taquary on 17/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import UIKit
import Reusable

final class MovieViewCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    
    static func size(for parentWidth: CGFloat) -> CGSize {
        let numberOfCells = CGFloat(2)
        let width = parentWidth / numberOfCells
        return CGSize(width: width, height: width + 30)
    }
    
    
    func setup(item: Movie) {
        titleLabel.text = item.title
        posterImage.download(image: "\(ImageBasePath.url)\(item.posterPath)")
    }
    
    override func awakeFromNib() {
        self.posterImage.layer.borderColor = UIColor.lightGray.cgColor
        self.posterImage.layer.borderWidth = 1
        self.posterImage.layer.cornerRadius = 5
    }
    

    
}
