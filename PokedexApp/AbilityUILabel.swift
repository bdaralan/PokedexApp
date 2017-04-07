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
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        //self.font = UIFont(name: String, size: CGFloat)
    }
}
