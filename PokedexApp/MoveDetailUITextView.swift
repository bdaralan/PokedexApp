//
//  MoveDetailUITextView.swift
//  PokedexApp
//
//  Created by Dara on 5/11/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class MoveDetailUITextView: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    private func configureView() {
        layer.borderWidth = 1
        layer.cornerRadius = 20
        clipsToBounds = true
        isScrollEnabled = false
        isEditable = false
        textAlignment = .center
        layer.borderColor = UIColor.black.cgColor
        font = Constant.Font.gillSans
    }
}
