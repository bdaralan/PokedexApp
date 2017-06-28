//
//  TypeUILabel.swift
//  PokedexApp
//
//  Created by Dara on 4/6/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

protocol TypeUILabelDelegate: class {
    
    func typeUILabel(didTap tapGesture: UITapGestureRecognizer)
}


class TypeUILabel: UILabel {
    
    weak var delegate: TypeUILabelDelegate?
        
    private var tapGesture: UITapGestureRecognizer!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        self.textColor = UIColor.white
        self.textAlignment = .center
        self.baselineAdjustment = .alignCenters
        self.font = Constant.Font.gillSans
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
                self.backgroundColor = UIColor.MyColor.getColor(from: text)
            }
        }
    }
    
    override var isUserInteractionEnabled: Bool {
        didSet {
            if isUserInteractionEnabled {
                if tapGesture == nil {
                    tapGesture = UITapGestureRecognizer(target: self, action: #selector(typeUILabelTapped))
                }
                self.addGestureRecognizer(tapGesture)
                
            } else {
                if tapGesture != nil { self.removeGestureRecognizer(tapGesture) }
            }
        }
    }
    
    func typeUILabelTapped() {

        delegate?.typeUILabel(didTap: tapGesture)
    }
}



extension TypeUILabel {
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 80, height: 21))
    }
}
