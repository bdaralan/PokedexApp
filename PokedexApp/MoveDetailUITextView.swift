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
        configureView()
    }
    
    override var text: String! {
        didSet {
            let width = frame.width
            sizeToFit()
            frame.size.width = width
        }
    }
    
    private func configureView() {
        layer.borderWidth = 1.0
        layer.cornerRadius = 18.5
        clipsToBounds = true
        isScrollEnabled = false
        isEditable = false
        textAlignment = .center
        layer.borderColor = UIColor.black.cgColor
        font = Constant.Font.gillSans
    }
}
