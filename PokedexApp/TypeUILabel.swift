//
//  TypeUILabel.swift
//  PokedexApp
//
//  Created by Dara on 4/6/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class TypeUILabel: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        self.textColor = UIColor.white
        self.textAlignment = .center
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.frame.size.width = 80
        self.frame.size.height = 21
    }
}
