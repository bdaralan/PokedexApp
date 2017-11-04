//
//  AnimatableUIView.swift
//  PokedexApp
//
//  Created by Dara on 6/17/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class AnimatableUIView: UIView {}

/// Add pokemon defenses
extension AnimatableUIView {
    
    func addDefenseTypeLabels(of pokemon: Pokemon) {
        
        let typeCount = CGFloat(pokemon.defenses.count)
        let spacing: CGFloat = 16
        let height: CGFloat = TypeUILabel.defaultSize.height
        let heightConstraint = (height * typeCount) + (spacing * (typeCount + 2)) // +2 for top and bottom of stack
        heightAnchor.constraint(equalToConstant: heightConstraint).isActive = true
        
        // create a stack view for pokemonDefenseView
        let defenseContainerStackView = UIStackView()
        defenseContainerStackView.axis = .vertical
        defenseContainerStackView.distribution = .equalSpacing
        
        // stack view constraints
        addSubview(defenseContainerStackView)
        defenseContainerStackView.translatesAutoresizingMaskIntoConstraints = false
        defenseContainerStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85).isActive = true
        defenseContainerStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.85).isActive = true
        defenseContainerStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        defenseContainerStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        for (type, effective) in pokemon.defenses {
            let defenseStackView = PokemonDefenseStackView()
            switch effective {
            case "0": // immune
                defenseStackView.effectiveSlider.value = 0
                defenseStackView.effectiveSlider.setThumbImage(#imageLiteral(resourceName: "poke-effective-value-0x"), for: .normal)
            case "1/4": // 1/4x
                defenseStackView.effectiveSlider.value = 0.2
                defenseStackView.effectiveSlider.setThumbImage(#imageLiteral(resourceName: "poke-effective-value-1-4x"), for: .normal)
            case "1/2": // 1/2x
                defenseStackView.effectiveSlider.value = 0.4
                defenseStackView.effectiveSlider.setThumbImage(#imageLiteral(resourceName: "poke-effective-value-1-2x"), for: .normal)
            case "": // 1x
                defenseStackView.effectiveSlider.value = 0.6
                defenseStackView.effectiveSlider.setThumbImage(#imageLiteral(resourceName: "poke-effective-value-0x"), for: .normal)
            case "2": // 2x
                defenseStackView.effectiveSlider.value = 0.8
                defenseStackView.effectiveSlider.setThumbImage(#imageLiteral(resourceName: "poke-effective-value-2x"), for: .normal)
            case "4": // 4x
                defenseStackView.effectiveSlider.value = 1
                defenseStackView.effectiveSlider.setThumbImage(#imageLiteral(resourceName: "poke-effective-value-4x"), for: .normal)
            default: ()
            }
            defenseStackView.typeLabel.text = type
            defenseStackView.effectiveSlider.tintColor = DBColor.get(color: type)
            defenseContainerStackView.addArrangedSubview(defenseStackView)
        }
    }
}

/// Add pokemon pokedex entry
extension AnimatableUIView {
    
    func addTextView(text: String) {
        
        let textView: UITextView = {
            let textView = UITextView(frame: frame)
            textView.font = Constant.Font.appleSDGothicNeoRegular
            textView.isScrollEnabled = false
            textView.isEditable = false
            
            textView.text = text
            textView.sizeToFit()
            
            return textView
        }()
        
        // add constraints
        addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        let views: [String: UIView] = ["textView": textView]
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[textView]-16-|", options: [], metrics: nil, views: views)
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[textView]-|", options: [], metrics: nil, views: views)
        let selfHeight = NSLayoutConstraint.init(item: self, attribute: .bottom, relatedBy: .equal, toItem: textView, attribute: .bottom, multiplier: 1, constant: 8)
        addConstraints(hConstraints + vConstraints + [selfHeight])
        superview?.layoutIfNeeded()
    }
}
