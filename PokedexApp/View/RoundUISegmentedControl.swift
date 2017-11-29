//
//  RoundUISegmentedControl.swift
//  PokedexApp
//
//  Created by Dara on 4/16/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class RoundUISegmentedControl: UISegmentedControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    override init(items: [Any]?) {
        super.init(items: items)
        configureView()
    }
    
    private func configureView() {
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
        layer.borderWidth = 1
        layer.borderColor = self.tintColor.cgColor
    }
}
