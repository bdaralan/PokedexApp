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
    case insetLong
}

class RIOUILabel: UILabel {
    
    /// The round label at the right size of `self`, the main label.
    let roundLabel = UILabel()
    
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
        let leftInset = layer.cornerRadius < 4 ? 4 : layer.cornerRadius
        let insets = UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: 4)
        let rect = UIEdgeInsetsInsetRect(rect, insets)
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
    
    public func changeStyle(to style: RIOUILabelStyle) {
        roundLabelStyle = style
        guard let _ = superview else { return }
        switch style {
        case .regular: configureDefaultConstraints()
        case .insetLong: configureInsetLongConstraints()
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
    
    private func configureDefaultConstraints() {
        roundLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.deactivate(roundLabel.constraints)
        roundLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        roundLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        roundLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 2).isActive = true
        roundLabel.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 2).isActive = true
    }
    
    private func configureInsetLongConstraints() {
        roundLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.deactivate(roundLabel.constraints)
        let margin: CGFloat = 4
        roundLabel.topAnchor.constraint(equalTo: topAnchor, constant: margin).isActive = true
        roundLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin).isActive = true
        roundLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin).isActive = true
        roundLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3).isActive = true
    }
}
