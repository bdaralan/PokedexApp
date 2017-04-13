//
//  ViewLauncher.swift
//  PokedexApp
//
//  Created by Dara on 4/10/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class ViewLauncher: NSObject {
    
    private var parentView: UIViewController!
    
    private var presentingPositionY: CGFloat! //fixed, statusBar's height + navigationBar's height
    private var dismissPositionY: CGFloat! //vary according to the view that presents it
    private var animatedDuration: TimeInterval! //use for every view, unless otherwise
    private var isIdle: Bool!
    
    private var blackView: UIView!
    private var weaknessesView: UIView! //its frame is vary by how many weaknesses a pokemon has
    private var pokedexEnteryView: UIView!
    
    // Initializer
    init(parentView: UIViewController) {
        
        self.parentView = parentView
        self.animatedDuration = 0.5
        self.isIdle = true
        
        blackView = {
            let view = UIView()
            view.backgroundColor = UIColor(white: 0, alpha: 0.25)
            view.alpha = 0
            return view
        }()
        
        weaknessesView = {
            let view = UIView()
            view.backgroundColor = UIColor.white
            return view
        }()
        
        pokedexEnteryView = {
            let view = UIView()
            view.backgroundColor = UIColor.white
            return view
        }()
    }
    
    
    // Functions
    func presentWeaknesses(of pokemon: Pokemon) {
        
        if isIdle {
            isIdle = false
            addWeaknessLabels(for: pokemon)
            
            UIView.animate(withDuration: animatedDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.weaknessesView.frame.origin.y = self.presentingPositionY
            }, completion: { (Bool) in
                self.isIdle = true
            })
        }
    }
    
    func presentPokedexEntery(of pokemon: Pokemon) {
        
        if isIdle {
            isIdle = false
            addPokedexEnteryLabels(for: pokemon)
            
            UIView.animate(withDuration: animatedDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.pokedexEnteryView.frame.origin.y = self.presentingPositionY
            }) { (Bool) in
                self.isIdle = true
            }
        }
    }
    
    func dismissViews() {
        
        if isIdle {
            isIdle = false
            let weaknessViewDidPresent = (weaknessesView.frame.origin.y == presentingPositionY)
            
            UIView.animate(withDuration: animatedDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                self.blackView.alpha = 0
                
                if weaknessViewDidPresent {
                    self.weaknessesView.frame.origin.y = self.dismissPositionY
                } else {
                    self.pokedexEnteryView.frame.origin.y = self.dismissPositionY
                }
            }, completion: { (Bool) in
                if weaknessViewDidPresent {
                    self.removeAllSubView(from: self.weaknessesView)
                } else {
                    self.removeAllSubView(from: self.pokedexEnteryView)
                }
                self.isIdle = true
            })
        }
    }
    
    func configureLauncher() {
        
        if let navigationBar = parentView.navigationController?.navigationBar {
            let statusBarFrame = UIApplication.shared.statusBarFrame
            let width: CGFloat = navigationBar.frame.width
            
            presentingPositionY = statusBarFrame.height + navigationBar.frame.height
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissViews))
            blackView.addGestureRecognizer(tapGesture)
            
            let blackViewHeight = parentView.view.frame.height - presentingPositionY
            blackView.frame = CGRect(x: 0, y: presentingPositionY, width: width, height: blackViewHeight)
            
            let weaknessesViewSwipeUp = UISwipeGestureRecognizer(target: self, action: #selector(dismissViews))
            weaknessesViewSwipeUp.direction = .up
            weaknessesView.addGestureRecognizer(weaknessesViewSwipeUp)
            
            let pokedexEnteryViewSwipeUp = UISwipeGestureRecognizer(target: self, action: #selector(dismissViews))
            pokedexEnteryViewSwipeUp.direction = .up
            pokedexEnteryView.addGestureRecognizer(pokedexEnteryViewSwipeUp)
            
            parentView.view.addSubview(blackView)
            parentView.view.addSubview(weaknessesView)
            parentView.view.addSubview(pokedexEnteryView)
        }
    }
    
    private func addWeaknessLabels(for pokemon: Pokemon) {
        
        let weaknesses = pokemon.getWeaknesses()
        
        var y: CGFloat = 8
        let x: CGFloat = 20
        let width: CGFloat = 80
        let height: CGFloat = 21
        let spacing: CGFloat = 8
        
        for (type, effective) in weaknesses {
            let backgroundColor = COLORS.make(fromPokemonType: type)
            
            let typeLbl: TypeUILabel = {
                let label = TypeUILabel(frame: CGRect(x: x, y: y, width: width, height: height))
                label.awakeFromNib()
                label.backgroundColor = backgroundColor
                label.text = type
                return label
            }()
            
            let effectiveLbl: TypeUILabel = {
                let x = x + width + spacing
                var width = height //starting width
                
                if effective == "1/4" {
                    width = width * 2
                } else if effective == "1/2" {
                    width = width * 4
                } else if effective == "2" {
                    width = width * 8
                } else if effective == "4" {
                    width = parentView.view.frame.width - x - spacing
                } else if effective == "0" { // "0"
                    width = width * 2
                }
                
                let label = TypeUILabel(frame: CGRect(x: x, y: y, width: width, height: height))
                label.awakeFromNib()
                label.adjustsFontSizeToFitWidth = true
                label.text = "\(effective)x"
                
                if effective == "0" {
                    label.textAlignment = .left
                    label.font = UIFont(name: "\(label.font.fontName)-Bold", size: label.font.pointSize)
                    label.textColor = backgroundColor
                    label.backgroundColor = UIColor.white
                } else {
                    label.backgroundColor = backgroundColor
                }
                
                return label
            }()
            
            weaknessesView.addSubview(typeLbl)
            weaknessesView.addSubview(effectiveLbl)
            
            y = y + height + spacing
        }
        
        dismissPositionY = -(presentingPositionY + y)
        weaknessesView.frame = CGRect(x: 0, y: dismissPositionY, width: parentView.view.frame.width, height: y)
    }
    
    private func addPokedexEnteryLabels(for pokemon: Pokemon) {
        
        let x: CGFloat = 20
        let height: CGFloat = 250 // MARK: - Pokemon entery textView's height
        let width: CGFloat = parentView.view.frame.width - (x * 2)
        
        let textView: UITextView = {
            let textView = UITextView(frame: CGRect(x: x, y: 0, width: width, height: height))
            textView.isSelectable = false
            textView.alwaysBounceVertical = true
            textView.font = UIFont(name: "HelveticaNeue", size: 16)
            return textView
        }()
        
        dismissPositionY = -(presentingPositionY + height)
        pokedexEnteryView.frame = CGRect(x: 0, y: dismissPositionY, width: parentView.view.frame.width, height: height)
        
        if let pokedexEntery = POKEDEX_ENTERIES_JSON["\(pokemon.id)"] as? DictionarySS {
            if let omegaEntery = pokedexEntery["omega"], let alphaEntery = pokedexEntery["alpha"] {
                textView.text = "Omega Ruby:\n\(omegaEntery)\n\nAlpha Sapphire:\n\(alphaEntery)"
                pokedexEnteryView.addSubview(textView)
            }
        }
    }
    
    private func removeAllSubView(from superView: UIView) {
        
        for subView in superView.subviews {
            subView.removeFromSuperview()
        }
    }
}
