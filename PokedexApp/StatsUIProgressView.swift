//
//  StatsUIProgressView.swift
//  PokedexApp
//
//  Created by Dara on 4/21/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class StatsUIProgressView: UIProgressView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.progress = 0
        self.layer.frame.size.height = 3
        self.layer.cornerRadius = self.layer.frame.height / 2
        self.clipsToBounds = true
    }

}
