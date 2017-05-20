//
//  TypeUILabel.swift
//  PokedexApp
//
//  Created by Dara on 4/6/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

@objc protocol TypeUILabelDelegate {
    
    func typeUILabel(didTap tapGesture: UITapGestureRecognizer)
}


class TypeUILabel: UILabel {
    
    weak var delegate: TypeUILabelDelegate?
    
    private var tapGesture: UITapGestureRecognizer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        self.frame.size.width = 80
        self.frame.size.height = 21
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        self.textColor = UIColor.white
        self.textAlignment = .center
        self.baselineAdjustment = .alignCenters
        self.font = CONSTANTS.fonts.gillSans
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(typeUILabelTapped))
        self.addGestureRecognizer(tapGesture)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var text: String? {
        didSet {
            if let text = text {
                self.backgroundColor = UIColor.myColor.get(from: text)
            }
        }
    }
    
    func typeUILabelTapped() {
        
        delegate?.typeUILabel(didTap: tapGesture)
    }
}
