//
//  MeasurementUILabel.swift
//  PokedexApp
//
//  Created by Dara on 4/6/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class MeasurementUILabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    private func configureView() {
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
        backgroundColor = DBColor.AppObject.sectionBackground //.withAlphaComponent(0.35)
    }
}
