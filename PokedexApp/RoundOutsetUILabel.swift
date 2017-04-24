//
//  RoundOutsetUILabel.swift
//  CustomUIProject
//
//  Created by Dara on 4/23/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class RoundOutsetUILabel: UILabel {
    
    private var _roundLabel: UILabel!
    private var _addedToRadius: CGFloat = 10
    
    private var roundLabelOriginX: CGFloat {
        return self.frame.origin.x + (self.frame.width - radius)
    }
    
    private var roundLabelOriginY: CGFloat {
        return self.frame.origin.y - (radius - self.frame.height) / 2
    }
    
    private var radius: CGFloat {
        return self.frame.height + _addedToRadius
    }
    
    var roundLabel: UILabel {
        set { self._roundLabel = newValue }
        get { return self._roundLabel }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.configureLabels()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.awakeFromNib()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        self.superview?.addSubview(self.roundLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var frame: CGRect {
        didSet {
            if self._roundLabel == nil {
                self.roundLabel = UILabel(frame: CGRect(x: roundLabelOriginX, y: roundLabelOriginY, width: radius, height: radius))
            } else {
                self.roundLabel.frame.origin.x = roundLabelOriginX
                self.roundLabel.frame.origin.y = roundLabelOriginY
                self.roundLabel.frame.size.width = radius
                self.roundLabel.frame.size.height = radius
                self.roundLabel.layer.cornerRadius = radius / 2
                self.layer.cornerRadius = self.frame.height / 2
            }
        }
    }
    
    override var backgroundColor: UIColor? {
        didSet {
            self.roundLabel.layer.borderColor = self.backgroundColor?.cgColor
        }
    }
    
    private func configureLabels() {
        
        //configure self
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        self.adjustsFontSizeToFitWidth = true
        self.textAlignment = .center
        self.baselineAdjustment = .alignCenters
        self.textColor = UIColor.white
        self.backgroundColor = UIColor.black
        
        //configure roundLabel
        self.roundLabel.layer.cornerRadius = radius / 2
        self.roundLabel.clipsToBounds = true
        self.roundLabel.adjustsFontSizeToFitWidth = true
        self.roundLabel.textAlignment = .center
        self.roundLabel.baselineAdjustment = .alignCenters
        self.roundLabel.textColor = UIColor.black
        self.roundLabel.backgroundColor = UIColor.white
        self.roundLabel.layer.borderWidth = 1.5
    }
    
    /// - note: The roundLabel's radius should not be less than its main label's height
    func increaseRadius(by addedToRadius: CGFloat = 0) {
        
        let newRadius = radius + addedToRadius
        
        if newRadius >= self.frame.height {
            self._addedToRadius = self._addedToRadius + addedToRadius
            self.roundLabel.frame.size.width = newRadius
            self.roundLabel.frame.size.height = newRadius
            self.roundLabel.layer.cornerRadius = newRadius / 2
        } else {
            print("RoundOutsetUILabel Reminder: roundLabel's radius cannot be less than its main label's height (previous value is unchanged)")
        }
    }
    
    /// Use to re-align the roundLabel's position if it is out of position
    func alignLayoutIfNotInPosition() {
        
        if roundLabel.frame.origin.x != roundLabelOriginY || roundLabel.frame.origin.y != roundLabelOriginY {
            roundLabel.frame.origin.x = roundLabelOriginX
            roundLabel.frame.origin.y = roundLabelOriginY
        }
    }
}
