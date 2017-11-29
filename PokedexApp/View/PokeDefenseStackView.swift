//
//  PokeDefenseStackView.swift
//  PokedexApp
//
//  Created by Dara on 11/2/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class PokeDefenseStackView: UIStackView {
    
    let typeLabel = TypeUILabel()
    let effectiveSlider = DBUISlider()

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
        let width = size.width * 3 // add some horizontal width for typeLabel and effectiveProgressView
        let frame = CGRect(origin: .zero, size: CGSize(width: width, height: size.height))
        self.init(frame: frame)
        configureView()
    }
    
    private func configureView() {
        spacing = 16
        distribution = .fillProportionally
        configureTypeLabel()
        configureEffectiveSlider()
        configureConstraints()
    }
    
    private func configureConstraints() {
        let size = TypeUILabel.defaultSize
        addArrangedSubview(typeLabel)
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        typeLabel.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        addArrangedSubview(effectiveSlider)
        effectiveSlider.translatesAutoresizingMaskIntoConstraints = false
        effectiveSlider.centerYAnchor.constraint(equalTo: typeLabel.centerYAnchor).isActive = true
        effectiveSlider.heightAnchor.constraint(equalToConstant: size.height).isActive = true
    }
    
    private func configureTypeLabel() {
        typeLabel.text = "PokeType?"
    }
    
    private func configureEffectiveSlider() {
        effectiveSlider.maximumTrackTintColor = .clear
        effectiveSlider.isUserInteractionEnabled = false
        effectiveSlider.thumbTextLabel.text = "?"
        effectiveSlider.thumbTextLabel.textColor = .white
        effectiveSlider.thumbTextLabel.font = Constant.Font.gillSansSemiBold
        effectiveSlider.thumbTextLabel.adjustsFontSizeToFitWidth = true
        effectiveSlider.thumbTextLabel.minimumScaleFactor = 0.5
        effectiveSlider.thumbTextLabel.textInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
    }
}
