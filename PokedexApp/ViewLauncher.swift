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
    
    private var animatedDuration: TimeInterval! //use for every view, unless otherwise
    private var isViewlauncherIdle: Bool!
    
    private var blackView: LaunchView!
    private var weaknessesView: LaunchView! //its frame is vary by how many weaknesses a pokemon has
    private var pokedexEntryView: LaunchView!
    private var launchView: LaunchView!
    
    private let margin: CGFloat = 16
    private let spacing: CGFloat = 8
    
    
    // Initializer
    init(parentView: UIViewController) {
        super.init()
        
        self.parentView = parentView
        self.animatedDuration = 0.5
        self.isViewlauncherIdle = true
        
        blackView = {
            let view = LaunchView()
            view.backgroundColor = UIColor(white: 0, alpha: 0.25)
            view.alpha = 0
            return view
        }()
        
        weaknessesView = {
            let view = LaunchView()
            view.backgroundColor = UIColor.white
            return view
        }()
        
        pokedexEntryView = {
            let view = LaunchView()
            view.backgroundColor = UIColor.white
            return view
        }()
        
        configureLauncher()
    }
    
    
    // MARK: - Functions
    func presentWeaknesses(of pokemon: Pokemon) {
        
        if isViewlauncherIdle {
            isViewlauncherIdle = false
            addWeaknessLabels(for: pokemon)
            
            UIView.animate(withDuration: animatedDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.weaknessesView.frame.origin = self.weaknessesView.presentOrigin
            }, completion: { (Bool) in
                self.weaknessesView.updateDismisOrigin()
                self.isViewlauncherIdle = true
            })
        }
    }
    
    func presentPokedexEntry(of pokemon: Pokemon) {
        
        if isViewlauncherIdle {
            isViewlauncherIdle = false
            addPokedexEntryLabels(for: pokemon)
            
            UIView.animate(withDuration: animatedDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.pokedexEntryView.frame.origin = self.pokedexEntryView.presentOrigin
            }) { (Bool) in
                self.pokedexEntryView.updateDismisOrigin()
                self.isViewlauncherIdle = true
            }
        }
    }
    
    func dismissViews() {
        
        if isViewlauncherIdle {
            isViewlauncherIdle = false
            let weaknessViewDidPresent = (weaknessesView.frame.origin == weaknessesView.presentOrigin)
            
            UIView.animate(withDuration: animatedDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                self.blackView.alpha = 0
                
                if weaknessViewDidPresent {
                    self.weaknessesView.frame.origin = self.weaknessesView.dismissOrigin
                } else {
                    self.pokedexEntryView.frame.origin = self.pokedexEntryView.dismissOrigin
                }
            }, completion: { (Bool) in
                if weaknessViewDidPresent {
                    self.removeAllSubView(from: self.weaknessesView)
                } else {
                    self.removeAllSubView(from: self.pokedexEntryView)
                }
                self.isViewlauncherIdle = true
            })
        }
    }
    
    private func addWeaknessLabels(for pokemon: Pokemon) {
        
        weaknessesView.frame.origin = weaknessesView.dismissOrigin
        
        let weaknesses = pokemon.getWeaknesses()
        var y: CGFloat = 8
        
        for (type, effective) in weaknesses {
            let backgroundColor = COLORS.make(fromPokemonType: type)
            
            let typeLbl: TypeUILabel = {
                let label = TypeUILabel()
                label.awakeFromNib()
                label.frame.origin = CGPoint(x: margin, y: y)
                label.backgroundColor = backgroundColor
                label.text = type
                return label
            }()
            
            let effectiveLbl: TypeUILabel = {
                let label = TypeUILabel()
                label.awakeFromNib()
                label.frame.origin = CGPoint(x: margin + label.frame.width + spacing, y: y)
                
                // MARK: - Pokemon's weaknesses effective width
                if effective == "1/4" {
                    label.frame.size.width = label.frame.height * 2
                } else if effective == "1/2" {
                    label.frame.size.width = label.frame.height * 4
                } else if effective == "2" {
                    label.frame.size.width = label.frame.height * 8
                } else if effective == "4" {
                    label.frame.size.width = parentView.view.frame.width - label.frame.width - spacing - (margin * 2)
                } else if effective == "0" { // "0"
                    label.frame.size.width = label.frame.height * 2
                }
                
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
            
            y = y + effectiveLbl.frame.height + spacing
        }
        
        weaknessesView.frame.size = CGSize(width: parentView.view.frame.width, height: y)
        weaknessesView.dismissOrigin = weaknessesView.frame.origin
    }
    
    private func addPokedexEntryLabels(for pokemon: Pokemon) {
        
        pokedexEntryView.frame.origin = pokedexEntryView.dismissOrigin
        
        let textView: UITextView = {
            let textView = UITextView(frame: CGRect(x: margin, y: spacing, width: 0, height: 0))
            textView.isSelectable = false
            textView.alwaysBounceVertical = true
            textView.font = UIFont(name: "GillSans-Italic", size: 18)
            return textView
        }()
        
        textView.text = pokemon.getPokedexEntry()
        
        let width: CGFloat = parentView.view.frame.width - (margin * 2)
        textView.sizeToFit()
        textView.frame.size.width = width
        textView.frame.size.height = textView.contentSize.height
        pokedexEntryView.frame.size = CGSize(width: parentView.view.frame.width, height: textView.frame.height + (spacing * 2))
        
        pokedexEntryView.addSubview(textView)
    }
    
    private func removeAllSubView(from superView: UIView) {
        
        for subView in superView.subviews {
            subView.removeFromSuperview()
        }
    }
    
    private func configureLauncher() { // MARK: - Configure Launcher
        
        if let navigationBar = parentView.navigationController?.navigationBar {
            let presentOrigin = CGPoint(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBar.frame.height)
            blackView.presentOrigin = presentOrigin
            weaknessesView.presentOrigin = presentOrigin
            pokedexEntryView.presentOrigin = presentOrigin
            
            let width: CGFloat = navigationBar.frame.width
            let height = parentView.view.frame.height - presentOrigin.y
            blackView.frame = CGRect(x: 0, y: presentOrigin.y, width: width, height: height)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissViews))
            blackView.addGestureRecognizer(tapGesture)
            
            let swipeUpWeaknessesView = UISwipeGestureRecognizer(target: self, action: #selector(dismissViews))
            swipeUpWeaknessesView.direction = .up
            weaknessesView.addGestureRecognizer(swipeUpWeaknessesView)
            
            let swipeEntryView = UISwipeGestureRecognizer(target: self, action: #selector(dismissViews))
            swipeEntryView.direction = .up
            pokedexEntryView.addGestureRecognizer(swipeEntryView)
            
            parentView.view.addSubview(blackView)
            parentView.view.addSubview(weaknessesView)
            parentView.view.addSubview(pokedexEntryView)
        }
    }
}

private class LaunchView: UIView {
    
    private var _presentOrigin: CGPoint!
    private var _dismissOrigin: CGPoint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if let window = UIApplication.shared.keyWindow {
            _presentOrigin = CGPoint(x: 0, y: 0)
            _dismissOrigin = CGPoint(x: 0, y: -(window.frame.height))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var presentOrigin: CGPoint {
        
        set { self._presentOrigin = newValue }
        get { return self._presentOrigin }
    }
    
    var dismissOrigin: CGPoint {
        
        set { self._dismissOrigin = newValue }
        get { return self._dismissOrigin }
    }
    
    var isPresented: Bool {
        
        return self.frame.origin == self._presentOrigin
    }
    
    var isDismissed: Bool {
        
        return self.frame.origin == self._dismissOrigin
    }
    
    func updateDismisOrigin() {
        
        self._dismissOrigin.y = -(self.presentOrigin.y + self.frame.height)
    }
}
