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
        let rect = UIEdgeInsetsInsetRect(rect, UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
        super.drawText(in: rect)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.height / 2
    }
    
    private func configureView() {
        clipsToBounds = true
        backgroundColor = DBColor.Pokemon.ability
        textAlignment = .center
        baselineAdjustment = .alignCenters
    }
}
