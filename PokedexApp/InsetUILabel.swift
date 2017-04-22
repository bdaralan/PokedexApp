//
//  InsetUILabel.swift
//  PokedexApp
//
//  Created by Dara on 4/22/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class InsetUILabel: UILabel {

    private var spacing: CGFloat = 3 //default spacing between the inset label and the outter label
    private var radius: CGFloat!
    
    var innerLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.black
        self.textColor = UIColor.white
        self.clipsToBounds = true
        self.textAlignment = .center
        self.baselineAdjustment = .alignCenters
        self.adjustsFontSizeToFitWidth = true
        
        self.updateLayout()
        
        self.addSubview(innerLable)
    }
    
    override var frame: CGRect {
        didSet {
            updateLayout()
        }
    }
    
    func setSpacing(to spacing: CGFloat) {
        
        self.spacing = spacing
        self.updateRadius(forNewSpacing: spacing)
        
        innerLable.frame.origin.y = spacing
        innerLable.frame.size.width = radius
        innerLable.frame.size.height = radius
        innerLable.layer.cornerRadius = radius / 2
    }
    
    private func updateLayout() {
        
        self.layer.cornerRadius = self.frame.height / 2
        self.updateRadius(forNewSpacing: spacing)
        
        let x = self.frame.width - radius - spacing
        
        if innerLable == nil {
            innerLable = UILabel(frame: CGRect(x: x, y: spacing, width: radius, height: radius))
            innerLable.backgroundColor = UIColor.white
            innerLable.textColor = UIColor.black
            innerLable.clipsToBounds = true
            innerLable.adjustsFontSizeToFitWidth = true
            innerLable.textAlignment = .center
            innerLable.baselineAdjustment = .alignCenters
        } else {
            innerLable.frame.origin.x = x
            innerLable.frame.origin.y = spacing
            innerLable.frame.size.width = radius
            innerLable.frame.size.height = radius
        }
  
        innerLable.layer.cornerRadius = radius / 2
    }
    
    private func updateRadius(forNewSpacing newSpacing: CGFloat) {
        
        self.radius = self.frame.height - newSpacing * 2
    }
}
