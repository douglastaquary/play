//
//  PlayButton.swift
//  Play
//
//  Created by douglas taquary on 24/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import UIKit

public class PlayButton: UIButton {
    
    let grid: CGFloat = 8.0
    
    override public required init(frame: CGRect) {
        self.title = ""
        
        super.init(frame: frame)
        
        setBackgroundImage(UIImage.image(with: .green),
                           for: .normal)
        layer.cornerRadius = grid / 2
        layer.masksToBounds = true
        let padding = grid * 2
        contentEdgeInsets = UIEdgeInsetsMake(padding, padding, padding, padding)
    }
    
    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var title: String {
        didSet {
            let attributedString = NSAttributedString(string: title,
                                                      font: UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold),
                                                      color: .black)
            
            setAttributedTitle(attributedString,
                               for: .normal)
        }
    }
    
}
