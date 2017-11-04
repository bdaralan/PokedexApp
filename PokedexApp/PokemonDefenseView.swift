//
//  PokemonDefenseView.swift
//  PokedexApp
//
//  Created by Dara on 11/2/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class PokemonDefenseStackView: UIStackView {
    
    let typeLabel = TypeUILabel()
    let effectiveSlider = UISlider()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
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
        spacing = 16
        configureConstraints()
        configureTypeLabel()
        configureEffectiveSlider()
    }
    
    private func configureConstraints() {
        let size = TypeUILabel.defaultSize
        
        addArrangedSubview(typeLabel)
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        typeLabel.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        typeLabel.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        
        addArrangedSubview(effectiveSlider)
        effectiveSlider.translatesAutoresizingMaskIntoConstraints = false
        effectiveSlider.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        effectiveSlider.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        effectiveSlider.heightAnchor.constraint(equalToConstant: size.height).isActive = true
    }
    
    private func configureTypeLabel() {
        typeLabel.text = "PokemonType"
    }
    
    private func configureEffectiveSlider() {
        let thumbImage = UIImage(named: "poke-effective-value-x")
        effectiveSlider.setThumbImage(thumbImage, for: .normal)
        effectiveSlider.isUserInteractionEnabled = false
    }
}
