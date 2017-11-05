//
//  DBUISlider.swift
//  PokedexApp
//
//  Created by Dara on 11/4/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class DBUISlider: UISlider {
    
    let thumbTextLabel = DBUIInsetLabel()
    
    private var thumbImageFrame: CGRect {
        return thumbRect(forBounds: bounds, trackRect: trackRect(forBounds: bounds), value: value)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        thumbTextLabel.frame = thumbImageFrame
    }
    
    private func configureView() {
        configureThumbTextLabel()
    }
    
    private func configureThumbTextLabel() {
        addSubview(thumbTextLabel)
        thumbTextLabel.textAlignment = .center
        thumbTextLabel.baselineAdjustment = .alignCenters
        thumbTextLabel.layer.zPosition = layer.zPosition + 1
    }
}
