//
//  PokemonDefenseView.swift
//  PokedexApp
//
//  Created by Dara on 11/2/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class PokemonDefenseView: UIView {
    
    let typeLabel = TypeUILabel()
    let effectiveSlider = UISlider()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    convenience init() {
        let size = TypeUILabel.defaultSize
        let width = size.width * 2 + 24 // +value is spacing between typeLabel and effectiveProgressView
        let frame = CGRect(origin: .zero, size: CGSize(width: width, height: size.height))
        self.init(frame: frame)
        configureView()
    }
    
    private func configureView() {
        configureTypeLabel()
        configureEffectiveSlider()
    }
    
    private func configureTypeLabel() {
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(typeLabel)
        
        // constarints
        let width = typeLabel.frame.width
        let height = typeLabel.frame.height
        typeLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        typeLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        typeLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        typeLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func configureEffectiveSlider() {
        effectiveSlider.translatesAutoresizingMaskIntoConstraints = false
        addSubview(effectiveSlider)
        
        // constraints
        let height = TypeUILabel.defaultSize.height
        effectiveSlider.leadingAnchor.constraint(equalTo: typeLabel.trailingAnchor, constant: 24).isActive = true
        effectiveSlider.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        effectiveSlider.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        effectiveSlider.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        // set default thumb image
        let thumbImage = UIImage.init(named: "poke-effective-value-x")
        effectiveSlider.setThumbImage(thumbImage, for: .normal)
    }
}
