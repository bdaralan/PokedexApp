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
        let defenseStackView = UIStackView()
        defenseStackView.axis = .vertical
        defenseStackView.distribution = .equalSpacing
        
        // stack view constraints
        defenseStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(defenseStackView)
        defenseStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85).isActive = true
        defenseStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.85).isActive = true
        defenseStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        defenseStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        for (type, effective) in pokemon.defenses {
            let defenseView = PokemonDefenseView()
            defenseView.typeLabel.text = type
            switch effective {
            case "1/4":
                defenseView.effectiveSlider.value = 0.2
                defenseView.effectiveSlider.setThumbImage(#imageLiteral(resourceName: "poke-effective-value-1-4x"), for: .normal)
            case "1/2":
                defenseView.effectiveSlider.value = 0.4
                defenseView.effectiveSlider.setThumbImage(#imageLiteral(resourceName: "poke-effective-value-1-2x"), for: .normal)
            case "2":
                defenseView.effectiveSlider.value = 0.8
                defenseView.effectiveSlider.setThumbImage(#imageLiteral(resourceName: "poke-effective-value-2x"), for: .normal)
            case "4":
                defenseView.effectiveSlider.value = 1
                defenseView.effectiveSlider.setThumbImage(#imageLiteral(resourceName: "poke-effective-value-4x"), for: .normal)
            case "0":
                defenseView.effectiveSlider.value = 0
                defenseView.effectiveSlider.setThumbImage(#imageLiteral(resourceName: "poke-effective-value-0x"), for: .normal)
            default:
                defenseView.effectiveSlider.value = 0.6
                defenseView.effectiveSlider.setThumbImage(#imageLiteral(resourceName: "poke-effective-value-0x"), for: .normal)
            }
            
            defenseStackView.addArrangedSubview(defenseView)
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
        
        self.addSubview(textView)
        
        // add constraints
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        let views: [String: UIView] = ["textView": textView]
        
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[textView]-16-|", options: [], metrics: nil, views: views)
        
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[textView]-|", options: [], metrics: nil, views: views)
        
        let selfHeight = NSLayoutConstraint.init(item: self, attribute: .bottom, relatedBy: .equal, toItem: textView, attribute: .bottom, multiplier: 1, constant: 8)
        
        self.addConstraints(hConstraints + vConstraints + [selfHeight])
        self.superview?.layoutIfNeeded()
    }
}
