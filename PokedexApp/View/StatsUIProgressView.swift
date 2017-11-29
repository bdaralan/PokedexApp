//
//  StatsUIProgressView.swift
//  PokedexApp
//
//  Created by Dara on 4/21/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class StatsUIProgressView: UIProgressView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    private func configureView() {
        progress = 0
        layer.frame.size.height = 3
        layer.cornerRadius = self.layer.frame.height / 2
        clipsToBounds = true
    }
}
