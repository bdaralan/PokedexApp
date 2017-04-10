//
//  Extension.swift
//  PokedexApp
//
//  Created by Dara on 4/9/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

extension UILabel {
    
    func extend(length: CGFloat, hasSpacing space: CGFloat = 0) {
        
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width + length + space, height: self.frame.height)
    }
    
    func setLength(to length: CGFloat) {
        
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: length, height: self.frame.height)
    }
}
