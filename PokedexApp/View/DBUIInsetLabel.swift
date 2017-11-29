//
//  DBUIInsetLabel.swift
//  PokedexApp
//
//  Created by Dara on 11/4/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class DBUIInsetLabel: UILabel {
    
    /** Custom text insets. If this value is `nil`, the label will use the default insets. */
    var textInsets: UIEdgeInsets?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawText(in rect: CGRect) {
        var rect = rect
        if let textInsets = textInsets {
            rect = UIEdgeInsetsInsetRect(rect, textInsets)
        }
        super.drawText(in: rect)
    }
    
    convenience init(frame: CGRect, textInsets: UIEdgeInsets) {
        self.init(frame: frame)
        self.textInsets = textInsets
    }
}
