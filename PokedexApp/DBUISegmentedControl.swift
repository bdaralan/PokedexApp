//
//  DBUISegmentedControl.swift
//  PokedexApp
//
//  Created by Dara on 4/16/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class DBUISegmentedControl: UISegmentedControl {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = self.tintColor.cgColor
    }
}
