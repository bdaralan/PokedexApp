//
//  MoveDetailUITextView.swift
//  PokedexApp
//
//  Created by Dara on 5/11/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class MoveDetailUITextView: UITextView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 18.5
        self.clipsToBounds = true
        self.textAlignment = .center
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    func applyStyle() {
        
        let width = self.frame.width
        self.sizeToFit()
        self.frame.size.width = width
    }
}
