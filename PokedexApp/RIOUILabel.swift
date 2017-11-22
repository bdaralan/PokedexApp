//
//  RIOUILabel.swift
//  CustomUIProject
//
//  Created by Dara on 4/23/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

enum RIOUILabelStyle {
    case regular
    case longInsetRight
    case longInsetLeft
}

class RIOUILabel: UILabel {
    
    /// The round label at the right size of `self`, the main label.
    let roundLabel = UILabel()
    
    var textInset: UIEdgeInsets?
    
    public var roundLabelBorderWidth: CGFloat = 3 {
        didSet { roundLabel.layer.borderWidth =  roundLabelBorderWidth }
    }
    
    private var roundLabelStyle: RIOUILabelStyle = .regular
    
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
    
    override func drawText(in rect: CGRect) {
        let inset = textInset != nil ? textInset! : configureTextInset()
        let rect = UIEdgeInsetsInsetRect(rect, inset)
        super.drawText(in: rect)
    }
    
    override func didMoveToSuperview() {
        if let superview = superview {
            superview.addSubview(roundLabel)
            changeStyle(to: roundLabelStyle)
        } else {
            roundLabel.removeFromSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureRadius()
    }
    
    override var backgroundColor: UIColor? {
        didSet {
            roundLabel.layer.borderColor = backgroundColor?.cgColor
        }
    }
    
    /// Change label style. Check `RIOUILabelStyle` for style options.
    /// The default style is `.regular`.
    /// - note: Currently, change style before setup constraints.
    public func changeStyle(to style: RIOUILabelStyle) {
        roundLabelStyle = style
        guard let _ = superview else { return }
        switch style {
        case .regular: configureRegularConstraints()
        case .longInsetRight: configureLongInsetRightConstraints()
        case .longInsetLeft: configureLongInsetLeftConstraints()
        }
    }
    
    // TODO: - Implement the function to allow roundLabel resize by pass in a change in radius, dr.
//    /**
//     Use this to grow the `roundLabel` size. The passed in value will be use on both width and height.
//     - parameter dr: Pass in a negative number to shrink.
//     - parameter realignAfter: RIOLabel will make sure the round label is in the correct position
//     */
//    public func resizeRoundLabel(dr: CGFloat) {
//        roundLabelWidthConstraint.constant += dr
//        roundLabelHeighConstraint.constant += dr
//        configureRoundLabelRadius()
//    }

    private func configureView() {
        clipsToBounds = true
        adjustsFontSizeToFitWidth = true
        textAlignment = .center
        baselineAdjustment = .alignCenters
        textColor = UIColor.white
        backgroundColor = UIColor.black
        font = Constant.Font.gillSans
        configureRoundLabel()
    }
    
    private func configureTextInset() -> UIEdgeInsets {
        let leftInset: CGFloat
        let rightInset: CGFloat
        let spacing: CGFloat = 8
        
        switch roundLabelStyle {
        case .regular:
            leftInset = layer.cornerRadius < 4 ? 4 : layer.cornerRadius
            rightInset = roundLabel.frame.width + spacing
        case .longInsetRight:
            leftInset = layer.cornerRadius < 4 ? 4: layer.cornerRadius
            rightInset = roundLabel.frame.width + spacing + 4 // margin
        case .longInsetLeft:
            leftInset = roundLabel.frame.width + spacing + 4 // margin
            rightInset = layer.cornerRadius < 4 ? 4 : layer.cornerRadius
        }
        
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
    private func configureRoundLabel() {
        roundLabel.clipsToBounds = true
        roundLabel.adjustsFontSizeToFitWidth = true
        roundLabel.textAlignment = .center
        roundLabel.baselineAdjustment = .alignCenters
        roundLabel.textColor = UIColor.black
        roundLabel.backgroundColor = UIColor.white
        roundLabel.font = Constant.Font.gillSans
        roundLabel.layer.borderWidth = roundLabelBorderWidth
    }
    
    private func configureRadius() {
        layer.cornerRadius = frame.height / 2
        roundLabel.layer.cornerRadius = min(roundLabel.frame.width, roundLabel.frame.height) / 2
    }
    
    private func configureRegularConstraints() {
        roundLabel.translatesAutoresizingMaskIntoConstraints = false
        roundLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        roundLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        roundLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 2).isActive = true
        roundLabel.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 2).isActive = true
    }
    
    private func configureLongInsetRightConstraints() {
        roundLabel.translatesAutoresizingMaskIntoConstraints = false
        let margin: CGFloat = 4
        roundLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin).isActive = true
        roundLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        roundLabel.heightAnchor.constraint(equalTo: heightAnchor, constant: -margin * 2).isActive = true
        roundLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3).isActive = true
    }
    
    private func configureLongInsetLeftConstraints() {
        roundLabel.translatesAutoresizingMaskIntoConstraints = false
        let margin: CGFloat = 4
        roundLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin).isActive = true
        roundLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        roundLabel.heightAnchor.constraint(equalTo: heightAnchor, constant: -margin * 2).isActive = true
        roundLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3).isActive = true
    }
}
