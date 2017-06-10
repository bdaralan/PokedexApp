//
//  UIViewExtension.swift
//  PokedexApp
//
//  Created by Dara on 5/13/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

extension UIView: Animatable {}


extension UIView {
    
    convenience init(pokemonWeaknesses pokemon: Pokemon) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        let spacing = Constant.Constrain.spacing
        let margin = Constant.Constrain.margin
        
        var y: CGFloat = spacing
        
        let weaknesses = pokemon.weaknesses
        var weaknessLabels = [TypeUILabel]()
        
        for (type, effective) in weaknesses {
            
            let typeLabel: TypeUILabel = {
                let label = TypeUILabel()
                label.frame.origin.x = margin
                label.frame.origin.y = y
                label.text = type
                return label
            }()
            
            let effectiveLabel: TypeUILabel = {
                let label = TypeUILabel()
                label.frame.origin.x = margin + label.frame.width + spacing
                label.frame.origin.y = y
                label.text = "\(effective)x"
                label.backgroundColor = typeLabel.backgroundColor
                
                // MARK: - Pokemon's weaknesses effective width
                if effective == "1/4" {
                    label.frame.size.width = label.frame.height * 2
                } else if effective == "1/2" {
                    label.frame.size.width = label.frame.height * 4
                } else if effective == "2" {
                    label.frame.size.width = label.frame.height * 8
                } else if effective == "4" {
                    label.frame.size.width = self.frame.width - label.frame.width - spacing - (margin * 2)
                } else if effective == "0" { // "0"
                    label.frame.size.width = label.frame.height * 2
                    label.textAlignment = .left
                    label.font = UIFont(name: "\(label.font.fontName)-Bold", size: label.font.pointSize)
                    label.textColor = typeLabel.backgroundColor
                    label.backgroundColor = UIColor.clear
                }
                
                return label
            }()
            
            weaknessLabels.append(typeLabel)
            weaknessLabels.append(effectiveLabel)
            
            y += typeLabel.frame.height + spacing
            self.frame.size.height = y
        }
        
        guard let windowFrame = UIApplication.shared.keyWindow?.frame else { return }
        self.frame.size.width = windowFrame.width
        self.frame.origin.x = windowFrame.width
        
        for label in weaknessLabels { self.addSubview(label) }
    }
    
    convenience init(pokedexEntry pokemon: Pokemon) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        let margin = Constant.Constrain.margin
        
        let textView: UITextView = {
            let textView = UITextView(frame: CGRect(x: margin, y: 8, width: 0, height: 0))
            textView.font = Constant.Font.appleSDGothicNeoRegular
            textView.isScrollEnabled = false
            textView.isEditable = false
            
            return textView
        }()
        
        textView.text = pokemon.pokedexEntry
        textView.sizeToFit()
        
        guard let windowFrame = UIApplication.shared.keyWindow?.frame else { return }
        self.frame.size.width = windowFrame.width
        self.frame.size.height = textView.frame.height
        self.addSubview(textView)
    }
}


extension UIView {
    
    class func animate(views: [UIView], to toOrigin: CGPoint, withDuration duration: TimeInterval, willReturn: Bool = false, action: (), completion: ()) {
        
        let returnOriginY = views.first?.frame.origin.y
        
        self.animate(withDuration: duration, animations: {
            
            for view in views {
                view.frame.origin.y = toOrigin.y
                view.alpha = 0
            }
        }) { (Bool) in
            action
            self.animate(withDuration: duration, animations: {
                if willReturn, let toY = returnOriginY {
                    for view in views {
                        view.frame.origin.y = toY
                        view.alpha = 1
                    }
                }
            }) { (Bool) in
                completion
            }
        }
    }
    
    func removeAllSubviews() {
        
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
    
    func setOriginBelow(_ view: UIView, spacing: CGFloat = 8) {
        
        self.frame.origin.y = view.frame.origin.y + view.frame.height + spacing
    }
    
    func sizeToContent(verticalSpacing: CGFloat = 0) {
        
        if let lastSubview = self.subviews.last {
            self.frame.size.height = lastSubview.frame.origin.y + lastSubview.frame.height + verticalSpacing * 2
        }
    }
}
