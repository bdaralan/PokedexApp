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
    
    private var presentingPositionY: CGFloat!
    private var dismissPositionY: CGFloat!
    private var animatedDuration: TimeInterval!
    
    private var blackView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.25)
        view.alpha = 0
        return view
    }()
    
    private var weaknessesView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private var pokedexEnteryView: UIView = {
        
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    private var weaknessesViewDidPresent: Bool {
        
        if self.weaknessesView.frame.origin.y == self.presentingPositionY {
            return true
        }
        return false
    }
    
    
    // Initializer
    init(parentView: UIViewController) {
        
        self.parentView = parentView
        self.animatedDuration = 0.5
    }
    
    func presentWeaknesses(of pokemon: Pokemon) {
        
        addWeaknessLabels(for: pokemon)
        
        UIView.animate(withDuration: animatedDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 1
            self.weaknessesView.frame.origin.y = self.presentingPositionY
        }, completion: nil)
    }
    
    func presentPokedexEntery(of pokemon: Pokemon) {
        
        addPokedexEnteryLabels(for: pokemon)
        
        UIView.animate(withDuration: animatedDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 1
            self.pokedexEnteryView.frame.origin.y = self.presentingPositionY
        }, completion: nil)
    }
    
    func dismissViews() {
        
        let weaknessesViewDidPresent = self.weaknessesViewDidPresent
        
        UIView.animate(withDuration: animatedDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.blackView.alpha = 0
            
            if weaknessesViewDidPresent {
                self.weaknessesView.frame.origin.y = self.dismissPositionY
            } else {
                self.pokedexEnteryView.frame.origin.y = self.dismissPositionY
            }
        }, completion: {(Bool) in
            if weaknessesViewDidPresent {
                self.removeAllSubView(from: self.weaknessesView)
            } else {
                self.removeAllSubView(from: self.pokedexEnteryView)
            }
        })
    }
    
    func addWeaknessLabels(for pokemon: Pokemon) {
        
        let height: CGFloat = 21
        let width: CGFloat = weaknessesView.frame.width
        let spacing: CGFloat = 8
        let x: CGFloat = 20
        var y: CGFloat = 8
        
        if let weaknessesInfo = WEAKNESSESS_JSON["\(pokemon.primaryType)\(pokemon.secondaryType)"] as? DictionarySS {
            for (type, damage) in weaknessesInfo where damage != "" {
                let label = UILabel()
                label.contentMode = .left
                label.frame = CGRect(x: x, y: y, width: width, height: 21)
                label.text = "\(type): \(damage)x"
                weaknessesView.addSubview(label)
                y = y + height + spacing
            }
        }
    }
    
    func addPokedexEnteryLabels(for pokemon: Pokemon) {
        
        let x: CGFloat = 20
        let y: CGFloat = 8
        let height: CGFloat = 200 // TODO: - should be dynamic
        let width: CGFloat = pokedexEnteryView.frame.width - (x * 2)
        let textView = UITextView(frame: CGRect(x: x, y: y, width: width, height: height))
        
        if let pokedexEntery = POKEDEX_ENTERIES_JSON["\(pokemon.id)"] as? DictionarySS {
            if let omegaEntery = pokedexEntery["omega"], let alphaEntery = pokedexEntery["alpha"] {
                textView.text = "\(omegaEntery)\n\n\(alphaEntery)"
                pokedexEnteryView.addSubview(textView)
            }
        }
    }
    
    func configureViews() {
        
        if let navigationBar = parentView.navigationController?.navigationBar {
            let statusBarFrame = UIApplication.shared.statusBarFrame
            let width: CGFloat = navigationBar.frame.width
            let height: CGFloat = 300 // TODO: - should be dynamic
            
            presentingPositionY = statusBarFrame.height + navigationBar.frame.height
            dismissPositionY = -(statusBarFrame.height + navigationBar.frame.height + height)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissViews))
            blackView.addGestureRecognizer(tapGesture)
            
            let blackViewHeight = parentView.view.frame.height - presentingPositionY
            blackView.frame = CGRect(x: 0, y: presentingPositionY, width: width, height: blackViewHeight)
            
            weaknessesView.frame = CGRect(x: 0, y: dismissPositionY, width: width, height: height)
            pokedexEnteryView.frame = CGRect(x: 0, y: dismissPositionY, width: width, height: height)
            
            parentView.view.addSubview(blackView)
            parentView.view.addSubview(weaknessesView)
            parentView.view.addSubview(pokedexEnteryView)
        }
    }
    
    private func removeAllSubView(from superView: UIView) {
        
        for subView in superView.subviews {
            subView.removeFromSuperview()
        }
    }
}
