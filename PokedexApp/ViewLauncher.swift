//
//  ViewLauncher.swift
//  PokedexApp
//
//  Created by Dara on 4/10/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

@objc protocol ViewLauncherDelegate: NSObjectProtocol {
    
    @objc optional func viewLauncher(willLaunchAt origin: CGPoint)
    @objc optional func viewlauncher(didLaunchAt origin: CGPoint)
    @objc optional func viewLauncher(WillDismissTo origin: CGPoint)
    @objc optional func viewLauncher(DidDismissTo origin: CGPoint)
    @objc optional func viewLaucher(shouldUpdate height: CGFloat) -> CGFloat
}

class ViewLauncher: NSObject {
    
    var delegate: ViewLauncherDelegate? = nil
    
    var launchView: UIView!
    var dimView: UIView!
    
    var animatedDuration: TimeInterval = 0.5
    var isRemoveSubviewsAfterDimissed: Bool = true
    var isIdle: Bool = true
    
    private var _launchOrigin: CGPoint!
    private var _dimissOrigin: CGPoint!
    private var _swipeToDismissDirection: UISwipeGestureRecognizerDirection!
    
    var dismissOrigin: CGPoint {
        set {
            _dimissOrigin = newValue
        }
        get {
            return _dimissOrigin
        }
    }
    
    
    init(launchViewFrame: CGRect, dimViewFrame: CGRect, swipeToDismissDirection: UISwipeGestureRecognizerDirection) {
        super.init()
        
        self._swipeToDismissDirection = swipeToDismissDirection
        self._launchOrigin = launchViewFrame.origin
        self._dimissOrigin = CGPoint(x: launchViewFrame.origin.x, y: -(launchViewFrame.origin.y + launchViewFrame.height))
        
        self.launchView = {
            let view = UIView(frame: launchViewFrame)
            view.backgroundColor = UIColor.white
            
            let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismiss(withDuration:)))
            swipeUpGesture.direction = swipeToDismissDirection
            view.addGestureRecognizer(swipeUpGesture)
            
            return view
        }()
        
        self.launchView.frame.origin = self.dismissOrigin
        
        self.dimView = {
            let view = UIView(frame: dimViewFrame)
            view.backgroundColor = UIColor(white: 0, alpha: 0.3)
            view.alpha = 0
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismiss(withDuration:)))
            view.addGestureRecognizer(tapGesture)
            
            return view
        }()
    }
    
    func setSuperview(_ superview: UIView) {
        
        superview.addSubview(self.dimView)
        superview.addSubview(self.launchView)
    }
    
    func removeFromSuperview() {
        
        self.dimView.removeFromSuperview()
        self.launchView.removeFromSuperview()
    }
    
    func addSubview(_ subview: UIView) {
        
        subview.sizeToFit()
        subview.frame.size.width = launchView.frame.width - (subview.frame.origin.x * 2)
        
        launchView.frame.size.height = subview.frame.height
        
        launchView.addSubview(subview)
    }
    
    func launch(withDuration duration: TimeInterval = 0, withHeight height: CGFloat = 0) {
        
        if self.isIdle {
            self.isIdle = false
            
            if height > 0 { self.launchView.frame.size.height = height }
            
            if self.delegate != nil {
                self.delegate?.viewLauncher!(willLaunchAt: self._launchOrigin)
            }
            
            var duration = duration
            if duration == 0 { duration = animatedDuration }
            
            self.launchView.frame.origin = dismissOrigin
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.dimView.alpha = 1
                self.launchView.frame.origin = self._launchOrigin
            }) { (Bool) in
                if self.delegate != nil {
                    self.delegate?.viewlauncher!(didLaunchAt: self._launchOrigin)
                }
                self.isIdle = true
            }
        }
    }
    
    func dismiss(withDuration duration: TimeInterval = 0) {
        
        if self.isIdle {
            self.isIdle = false
            if delegate != nil {
                self.delegate?.viewLauncher!(WillDismissTo: self.dismissOrigin)
            }
            
            var duration = duration
            if duration == 0 { duration = animatedDuration }
            
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.dimView.alpha = 0
                self.launchView.frame.origin = self.dismissOrigin
            }) { (Bool) in
                if self.isRemoveSubviewsAfterDimissed {
                    for subview in self.launchView.subviews {
                        subview.removeFromSuperview()
                    }
                }
                
                if self.delegate != nil {
                    self.delegate?.viewLauncher!(WillDismissTo: self.dismissOrigin)
                }
                
                self.isIdle = true
            }
        }
    }
}



// MARK: - ViewLauncher Extention
extension ViewLauncher {
    
    func getWeaknessView(of pokemon: Pokemon) -> UIView {
        
        let spacing = CONSTANTS.constrain.spacing
        let margin = CONSTANTS.constrain.margin
        var y: CGFloat = spacing //will keep increasing as more weakness labels are added
        
        let weaknessesView = UIView(frame: CGRect(x: 0, y: 0, width: self.launchView.frame.width, height: y))
        var weaknessLabels = [UILabel]()
        
        // TODO: - fix this repeated calculation when caching
        if let cachedWeaknessLabels = globalCache.object(forKey: "cachedWeaknessLabels\(pokemon.primaryType)\(pokemon.secondaryType)" as AnyObject) as? [UILabel] {
            weaknessLabels = cachedWeaknessLabels
            
            for i in 0 ..< weaknessLabels.count / 2 {
                y = y + weaknessLabels[i].frame.height + spacing
            }
        } else if let cachedWeaknessLabels = globalCache.object(forKey: "cachedWeaknessLabels\(pokemon.secondaryType)\(pokemon.primaryType)" as AnyObject) as? [UILabel] {
            weaknessLabels = cachedWeaknessLabels
            
            for i in 0 ..< weaknessLabels.count / 2 {
                y = y + weaknessLabels[i].frame.height + spacing
            }
        } else {
            let weaknesses = pokemon.getWeaknesses()
            
            for (type, effective) in weaknesses {
                let backgroundColor = COLORS.get(from: type)
                
                let typeLbl: TypeUILabel = {
                    let label = TypeUILabel()
                    label.awakeFromNib()
                    label.frame.origin.x = margin
                    label.frame.origin.y = y
                    label.backgroundColor = backgroundColor
                    label.text = type
                    return label
                }()
                
                let effectiveLbl: TypeUILabel = {
                    let label = TypeUILabel()
                    label.awakeFromNib()
                    label.frame.origin.x = margin + label.frame.width + spacing
                    label.frame.origin.y = y
                    label.backgroundColor = backgroundColor
                    label.text = "\(effective)x"
                    
                    // MARK: - Pokemon's weaknesses effective width
                    if effective == "1/4" {
                        label.frame.size.width = label.frame.height * 2
                    } else if effective == "1/2" {
                        label.frame.size.width = label.frame.height * 4
                    } else if effective == "2" {
                        label.frame.size.width = label.frame.height * 8
                    } else if effective == "4" {
                        label.frame.size.width = self.launchView.frame.width - label.frame.width - spacing - (margin * 2)
                    } else if effective == "0" { // "0"
                        label.frame.size.width = label.frame.height * 2
                        label.textAlignment = .left
                        label.font = UIFont(name: "\(label.font.fontName)-Bold", size: label.font.pointSize)
                        label.textColor = backgroundColor
                        label.backgroundColor = UIColor.white
                    }
                    
                    return label
                }()
                
                weaknessLabels.append(typeLbl)
                weaknessLabels.append(effectiveLbl)
                
                y = y + typeLbl.frame.height + spacing
            }
            
            globalCache.setObject(weaknessLabels as AnyObject, forKey: "cachedWeaknessLabels\(pokemon.primaryType)\(pokemon.secondaryType)" as AnyObject)
        }
        
        weaknessesView.frame.size.height = y
        
        for weakness in weaknessLabels {
            weaknessesView.addSubview(weakness)
        }
        
        return weaknessesView
    }
    
    func getPokedexEntryView(of pokemon: Pokemon) -> UIView {
        
        let textView: UITextView!
        
        if let cachedTextView = globalCache.object(forKey: "cachedTextView\(pokemon.id)" as AnyObject) as? UITextView {
            textView = cachedTextView
        } else {
            let margin = CONSTANTS.constrain.margin
            
            textView = {
                let width = self.launchView.frame.width - (margin * 2)
                let textView = UITextView(frame: CGRect(x: margin, y: 0, width: width, height: 31))
                textView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
                textView.isScrollEnabled = false
                textView.isEditable = false
                
                return textView
            }()
            
            textView.text = pokemon.getPokedexEntry()
            textView.sizeToFit()
            textView.frame.size.width = self.launchView.frame.width - margin * 2
            
            globalCache.setObject(textView, forKey: "cachedTextView\(pokemon.id)" as AnyObject)
        }
        
        let pokedexEntryView = UIView(frame: CGRect(x: 0, y: 0, width: self.launchView.frame.width, height: textView.frame.height))
        pokedexEntryView.addSubview(textView)
        
        return pokedexEntryView
    }
}
