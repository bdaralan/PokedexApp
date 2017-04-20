//
//  CircleUILabel.swift
//  PokedexApp
//
//  Created by Dara on 4/20/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class CircleUILabel: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        self.textColor = UIColor.white
        self.textAlignment = .center
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.frame.size.width = self.frame.height
    }
    
    func setRadius(to radius: CGFloat) {
        
        self.frame.size.width = radius
        self.frame.size.height = radius
    }
    
    func applyMoveCategoryStyle() {
        
        if let moveCategory = self.text {
            self.backgroundColor = COLORS.make(from: moveCategory)
            self.textColor = UIColor.white
            
            switch moveCategory {
            case "Physical": self.text = "P"
            case "Special": self.text = "S"
            case "Status": self.text = "S"
            default:
                self.text = "–"
                self.textColor = UIColor.black
            }
        }
    }
}
