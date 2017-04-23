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
    private var didAwakeFromNib = false
    
    private var radius: CGFloat {
        return self.frame.height - spacing * 2
    }
    
    private var innerLabelOriginX: CGFloat {
        return self.frame.width - radius - spacing
    }
    
    var innerLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.black
        self.textColor = UIColor.white
        self.clipsToBounds = true
        self.textAlignment = .center
        self.baselineAdjustment = .alignCenters
        self.adjustsFontSizeToFitWidth = true
        
        self.configureLayout()
        
        innerLable.backgroundColor = UIColor.white
        innerLable.textColor = UIColor.black
        innerLable.clipsToBounds = true
        innerLable.adjustsFontSizeToFitWidth = true
        innerLable.textAlignment = .center
        innerLable.baselineAdjustment = .alignCenters
        
        didAwakeFromNib = true
    }
    
    override var frame: CGRect {
        didSet {
            if didAwakeFromNib {
                self.configureLayout()
            } else {
                self.innerLable = UILabel(frame: CGRect(x: innerLabelOriginX, y: spacing, width: radius, height: radius))
                self.addSubview(innerLable)
            }
        }
    }
    
    func setSpacing(to spacing: CGFloat) {
        
        self.spacing = spacing
        self.configureLayout()
    }
    
    private func configureLayout() {
        
        innerLable.frame.origin.x = innerLabelOriginX
        innerLable.frame.origin.y = spacing
        innerLable.frame.size.width = radius
        innerLable.frame.size.height = radius
        
        self.layer.cornerRadius = self.frame.height / 2
        self.innerLable.layer.cornerRadius = radius / 2
    }
}
