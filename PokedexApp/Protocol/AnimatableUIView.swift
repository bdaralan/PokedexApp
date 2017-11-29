//
//  AnimatableUIView.swift
//  PokedexApp
//
//  Created by Dara on 6/17/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class AnimatableUIView: UIView {}

/** Add pokemon defenses */
extension AnimatableUIView {
    // TODO: defenses labels
//    func addDefenseTypeLabels(of pokemon: Pokemon) {
//        
//        let typeCount = CGFloat(pokemon.defenses.count)
//        let spacing: CGFloat = 16
//        let viewHeight: CGFloat = TypeUILabel.defaultSize.height
//        let viewHeightConstant = (viewHeight + spacing) * typeCount + spacing // an extra spacing for the top of the stack
//        heightAnchor.constraint(equalToConstant: viewHeightConstant).isActive = true
//        
//        // create a stack view for pokemonDefenseView
//        let defenseContainerStackView = UIStackView()
//        defenseContainerStackView.axis = .vertical
//        defenseContainerStackView.distribution = .fillEqually
//        defenseContainerStackView.spacing = spacing
//        
//        // stack view constraints
//        let defenseHeightConstant = viewHeightConstant - spacing * 2
//        addSubview(defenseContainerStackView)
//        defenseContainerStackView.translatesAutoresizingMaskIntoConstraints = false
//        defenseContainerStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.85).isActive = true
//        defenseContainerStackView.heightAnchor.constraint(equalToConstant: defenseHeightConstant).isActive = true
//        defenseContainerStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        defenseContainerStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        
//        for (type, effective) in pokemon.defenses {
//            let defenseStackView = PokeDefenseStackView()
//            defenseContainerStackView.addArrangedSubview(defenseStackView)
//            
//            var effectiveValue: Float = 0
//            var effectiveValueString = defenseStackView.effectiveSlider.thumbTextLabel.text
//            switch effective { // empty, "", is 1x, but will not show
//            case "0":
//                effectiveValue = 0
//                effectiveValueString = "0x"
//            case "1/4":
//                effectiveValue = 0.25
//                effectiveValueString = "1/4x"
//            case "1/2":
//                effectiveValue = 0.5
//                effectiveValueString = "1/2x"
//            case "2":
//                effectiveValue = 0.75
//                effectiveValueString = "2x"
//            case "4":
//                effectiveValue = 1
//                effectiveValueString = "4x"
//            default: ()
//            }
//            let tintColor = DBColor.get(color: type)
//            defenseStackView.typeLabel.text = type
//            defenseStackView.effectiveSlider.value = effectiveValue
//            defenseStackView.effectiveSlider.thumbTextLabel.text = effectiveValueString
//            defenseStackView.effectiveSlider.tintColor = tintColor
//            defenseStackView.effectiveSlider.thumbTintColor = tintColor
//        }
//    }
}

/** Add pokemon pokedex entry */
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
