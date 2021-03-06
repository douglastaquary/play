//
//  NSAttributedString+FontColor.swift
//  Play
//
//  Created by douglas taquary on 17/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import UIKit

extension NSAttributedString {
    
    convenience init(string: String, font: UIFont?, color: UIColor?) {
        var attributes = [String: Any]()
        
        if let font = font {
            attributes[NSFontAttributeName] = font
        }
        
        if let color = color {
            attributes[NSForegroundColorAttributeName] = color
        }
        
        self.init(string: string, attributes: attributes)
    }
    
    func highlight(string highlightString: String,
                   font: UIFont?,
                   color: UIColor?) -> NSAttributedString {
        
        guard highlightString.count != 0 else {
            return self
        }
        
        let string = self.string as NSString
        let range = string.range(of: highlightString)
        
        guard range.location != NSNotFound else {
            return self
        }
        
        let attributedString = NSMutableAttributedString(attributedString: self)
        
        if let font = font {
            attributedString.addAttribute(NSFontAttributeName,
                                          value: font,
                                          range: range)
        }
        
        if let color = color {
            attributedString.addAttribute(NSForegroundColorAttributeName,
                                          value: color,
                                          range: range)
        }
        
        return NSAttributedString(attributedString: attributedString)
    }
    
}
