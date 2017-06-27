//
//  AbilityUILabel.swift
//  PokedexApp
//
//  Created by Dara on 4/6/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class AbilityUILabel: UILabel {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        self.backgroundColor = UIColor.MyColor.Pokemon.ability
        self.textAlignment = .center
        self.baselineAdjustment = .alignCenters
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: CGRect(x: 8, y: 0, width: rect.width - 16, height: rect.height))
    }
}
