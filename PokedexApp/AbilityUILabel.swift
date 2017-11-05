//
//  AbilityUILabel.swift
//  PokedexApp
//
//  Created by Dara on 4/6/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class AbilityUILabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: CGRect(x: 8, y: 0, width: rect.width - 16, height: rect.height))
    }
    
    private func configureView() {
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
        backgroundColor = DBColor.Pokemon.ability
        textAlignment = .center
        baselineAdjustment = .alignCenters
    }
}
