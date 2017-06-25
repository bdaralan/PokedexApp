//
//  AnimatableUIView.swift
//  PokedexApp
//
//  Created by Dara on 6/17/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class AnimatableUIView: UIView {}

/// Add pokemon weaknesses
extension AnimatableUIView {
    
    func addWeaknessTypeLabels(of pokemon: Pokemon) {
        
        let weaknesses = pokemon.weaknesses
        
        var typeLabels = [TypeUILabel]()
        var effectiveLabels = [TypeUILabel]()
        
        // Append typeLabels and effectiveLabels for its number of weaknesses
        for (type, effective) in weaknesses {
            
            let typeLabel = TypeUILabel()
            typeLabel.text = type
            
            let effectiveLabel = TypeUILabel()
            effectiveLabel.text = "\(effective)x"
            effectiveLabel.backgroundColor = typeLabel.backgroundColor
            
            typeLabels.append(typeLabel)
            effectiveLabels.append(effectiveLabel)
        }
        
        // Add constraints
        for i in 0 ..< typeLabels.count {
            
            let typeLabel = typeLabels[i]
            let effectiveLabel = effectiveLabels[i]
            
            self.addSubview(typeLabel)
            self.addSubview(effectiveLabel)
            
            typeLabel.translatesAutoresizingMaskIntoConstraints = false
            effectiveLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let views = ["typeLabel": typeLabel, "effectiveLabel": effectiveLabel]
            
            var hConstraints = [NSLayoutConstraint]() // vConstraints for both type and effecitve label
            var typeLabelVContraints = [NSLayoutConstraint]()
            var effectiveLabelWidthConstraint = NSLayoutConstraint()
            var effectiveLabelCenterYConstrant = NSLayoutConstraint()
            
            
            // add vConstraints
            if i == 0 {
                typeLabelVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[typeLabel(21)]", options: [], metrics: nil, views: views)
                
            } else {
                typeLabelVContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[prevTypeLabel(21)]-8-[typeLabel(21)]", options: [], metrics: nil, views: ["prevTypeLabel": typeLabels[i - 1], "typeLabel": typeLabels[i]])
            }
            
            // add hConstraints
            hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[typeLabel(80)]-[effectiveLabel]", options: [], metrics: nil, views: views)
            
            effectiveLabelCenterYConstrant = NSLayoutConstraint.init(item: effectiveLabel, attribute: .centerY, relatedBy: .equal, toItem: typeLabel, attribute: .centerY, multiplier: 1, constant: 0)
            
            // add width constraint for effective label
            switch effectiveLabel.text! {
                
            case "1/4x":
                effectiveLabelWidthConstraint = NSLayoutConstraint.init(item: effectiveLabel, attribute: .width, relatedBy: .equal, toItem: typeLabel, attribute: .height, multiplier: 2, constant: 0)
                
            case "1/2x":
                effectiveLabelWidthConstraint = NSLayoutConstraint.init(item: effectiveLabel, attribute: .width, relatedBy: .equal, toItem: typeLabel, attribute: .height, multiplier: 4, constant: 0)
                
            case "2x":
                effectiveLabelWidthConstraint = NSLayoutConstraint.init(item: effectiveLabel, attribute: .width, relatedBy: .equal, toItem: typeLabel, attribute: .height, multiplier: 8, constant: 0)
                
            case "4x":
                effectiveLabelWidthConstraint = NSLayoutConstraint.init(item: effectiveLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -16)
                
            case "0x":
                effectiveLabelWidthConstraint = NSLayoutConstraint.init(item: effectiveLabel, attribute: .width, relatedBy: .equal, toItem: typeLabel, attribute: .height, multiplier: 2, constant: 0)
                
                effectiveLabel.textAlignment = .left
                effectiveLabel.backgroundColor = UIColor.clear
                
            default:()
            }
            
            self.addConstraints(typeLabelVContraints + hConstraints + [effectiveLabelWidthConstraint, effectiveLabelCenterYConstrant])
        }
        
        // adjust self height to containt all label, similar to .sizeToFit()
        guard let selfLastSubview = typeLabels.last else { return }
        let selfHeightConstraint = NSLayoutConstraint.init(item: self, attribute: .bottom, relatedBy: .equal, toItem: selfLastSubview, attribute: .bottom, multiplier: 1, constant: 16)
        
        self.addConstraint(selfHeightConstraint)
        self.superview?.layoutIfNeeded()
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
