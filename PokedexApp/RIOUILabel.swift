//
//  RIOUILabel.swift
//  CustomUIProject
//
//  Created by Dara on 4/23/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class RIOUILabel: UILabel {
    
    /// The round label at the right size of `self`, the main label.
    var roundLabel: RoundUILabel!
    
    /// The radius of the `roundLabel`. In most cases, its height is hightly prefered
    private var radius: CGFloat {
        return self.roundLabel.frame.height
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        superview?.addSubview(roundLabel)
    }
    
    override var frame: CGRect {
        didSet {
            if roundLabel == nil {
                let radius = frame.height + 12 //+12 to make sure initially roundLabel is larger than main label
                let x = frame.origin.x + (frame.width - radius)
                let y = frame.origin.y - (radius - frame.height) / 2
                roundLabel = RoundUILabel(frame: CGRect(x: x, y: y, width: radius, height: radius))
            } else {
                roundLabel.frame.origin.x = roundLabelOriginX
                roundLabel.frame.origin.y = roundLabelOriginY
                layer.cornerRadius = frame.height / 2
            }
        }
    }
    
    override var backgroundColor: UIColor? {
        didSet {
            roundLabel.layer.borderColor = backgroundColor?.cgColor
        }
    }
    
    override func drawText(in rect: CGRect) {
        let x: CGFloat = 5
        super.drawText(in: CGRect(x: x, y: 0, width: rect.width - x * 3 - radius / 2, height: rect.height))
    }
    
    private func configureView() {
        //configure self
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
        adjustsFontSizeToFitWidth = true
        textAlignment = .center
        baselineAdjustment = .alignCenters
        textColor = UIColor.white
        backgroundColor = UIColor.black
        font = Constant.Font.gillSans
        
        //configure roundLabel
        roundLabel.layer.cornerRadius = radius / 2
        roundLabel.clipsToBounds = true
        roundLabel.adjustsFontSizeToFitWidth = true
        roundLabel.textAlignment = .center
        roundLabel.baselineAdjustment = .alignCenters
        roundLabel.textColor = UIColor.black
        roundLabel.backgroundColor = UIColor.white
        roundLabel.layer.borderWidth = 3
        roundLabel.font = Constant.Font.gillSans
    }
}

extension RIOUILabel {
    
    /// Check if the `roundLabel` is vertically centered with the main label, `self`.
    var isRoundLabelVerticallyCentered: Bool {
        return roundLabel.frame.origin.y == roundLabelOriginY
    }
    
    /// Check if the `roundLabel` is at the end, its defaulf x position, of the main label.
    var isRoundLabelHorizontallyEnd: Bool {
        return roundLabel.frame.origin.x == roundLabelOriginX
    }
    
    /// The default x position where the `roundLabel` should be
    var roundLabelOriginX: CGFloat {
        return frame.origin.x + (frame.width - roundLabel.frame.width)
    }
    
    /// The default y position where the `roundLabel` should be
    var roundLabelOriginY: CGFloat {
        return frame.origin.y - (roundLabel.frame.height - frame.height) / 2
    }
    
    /**
     Use this to grow the `roundLabel` size. The passed in value will be use on both width and height.
     - parameter dr: Pass in a negative number to shrink.
     - parameter realignAfter: RIOLabel will make sure the round label is in the correct position
     */
    func resizeRoundLabel(dr: CGFloat, realignAfter: Bool = false) {
        roundLabel.frame.size.width += dr
        roundLabel.frame.size.height += dr
        
        switch roundLabel.frame.height > roundLabel.frame.width {
        case true: roundLabel.layer.cornerRadius = roundLabel.frame.width / 2
        case false: roundLabel.layer.cornerRadius = roundLabel.frame.height / 2
        }
        
        if realignAfter {
            realignIfNotVerticallyCentered()
        }
    }
    
    /**
     Check and align if the `roundLabel` is not vertically centered at the end of the main label, its default position. This behavior usually happens when directly resize `roundLabel` using `roundLabel.frame.size`.
     - note: To avoid miss position, use `growRoundLabelSize(by: CGFloat)` to increase or decrease its size.
     */
    func realignIfNotVerticallyCentered() {
        
        guard !isRoundLabelVerticallyCentered || !isRoundLabelHorizontallyEnd else { return }
        roundLabel.frame.origin.x = roundLabelOriginX
        roundLabel.frame.origin.y = roundLabelOriginY
    }
}

// MARK: - RoundUILabel

class RoundUILabel: UILabel {
    
    override func drawText(in rect: CGRect) {
        let x: CGFloat = 5
        super.drawText(in: CGRect(x: x, y: 0, width: rect.width - x * 2, height: rect.height))
    }
}
