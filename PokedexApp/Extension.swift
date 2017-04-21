//
//  Extension.swift
//  PokedexApp
//
//  Created by Dara on 4/9/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

extension UILabel {
    
    func setLength(to length: CGFloat) {
        
        self.frame.size.width = length
    }
}

extension Int {
    
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
}
