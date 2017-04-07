//
//  MeasurementUILabel.swift
//  PokedexApp
//
//  Created by Dara on 4/6/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class MeasurementUILabel: UILabel {

    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        self.backgroundColor = COLORS.sectionBackground.withAlphaComponent(0.4)
        //self.font = UIFont(name: String, size: CGFloat)
    }
}
