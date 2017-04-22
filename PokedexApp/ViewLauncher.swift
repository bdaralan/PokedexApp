//
//  ViewLauncher.swift
//  PokedexApp
//
//  Created by Dara on 4/10/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class ViewLauncher: NSObject {
    
    private var parentView: UIView!
    private var statusBarFrame: CGRect!
    private var navigationBarFrame: CGRect!
    private var launchOrigin: CGPoint!
    private var dimView: UIView!
    
    private let margin = CONSTANTS.constrain.margin
    private let spacing = CONSTANTS.constrain.spacing
    
    private let caches = NSCache<AnyObject, AnyObject>()
    
    init(parentView: UIViewController) {
        super.init()
        
        self.parentView = parentView.view
        
        if let navigationBarFrame = parentView.navigationController?.navigationBar.frame {
            self.navigationBarFrame = navigationBarFrame
            self.statusBarFrame = UIApplication.shared.statusBarFrame
            
            let x = parentView.view.frame.origin.x
            let y = statusBarFrame.height + navigationBarFrame.height
            self.launchOrigin = CGPoint(x: x, y: y)
        }
    }
    
    
    func presentWeaknessesView(of pokemon: Pokemon) {
        
        if let cachedLaunchView = caches.object(forKey: "launchView\(pokemon.primaryType)\(pokemon.secondaryType)" as AnyObject) {
            cachedLaunchView.launch()
        } else {
            let launchView = LaunchView(parentView: parentView)
            addWeaknessLabels(of: pokemon, into: launchView)
            caches.setObject(launchView, forKey: "launchView\(pokemon.primaryType)\(pokemon.secondaryType)" as AnyObject)
            launchView.launch()
        }
    }
    
    func presentPokedexEntryView(of pokemon: Pokemon) {
        
        if let cachedLaunchView = caches.object(forKey: "launchView\(pokemon.name)" as AnyObject) as? LaunchView {
            cachedLaunchView.launch()
        } else {
            let launchView = LaunchView(parentView: parentView)
            addPokedexEntry(of: pokemon, into: launchView)
            caches.setObject(launchView as AnyObject, forKey: "launchView\(pokemon.name)" as AnyObject)
            launchView.launch()
        }
    }
    
    func addWeaknessLabels(of pokemon: Pokemon, into launchView: LaunchView) {
        
        let weaknesses = pokemon.getWeaknesses()
        var y: CGFloat = spacing //will keep increasing as more weakness labels are added
        
        for (type, effective) in weaknesses {
            let backgroundColor = COLORS.make(from: type)
            
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
                    label.frame.size.width = parentView.frame.width - label.frame.width - spacing - (margin * 2)
                } else if effective == "0" { // "0"
                    label.frame.size.width = label.frame.height * 2
                    label.textAlignment = .left
                    label.font = UIFont(name: "\(label.font.fontName)-Bold", size: label.font.pointSize)
                    label.textColor = backgroundColor
                    label.backgroundColor = UIColor.white
                }
                
                return label
            }()
            
            launchView.addSubview(typeLbl)
            launchView.addSubview(effectiveLbl)
            
            y = y + typeLbl.frame.height + spacing
        }
        
        launchView.frame.size.height = y //update height to occupy its subviews
        launchView.setLaunchOrigin(to: launchOrigin)
    }
    
    func addPokedexEntry(of pokemon: Pokemon, into launchView: LaunchView) {
        
        let textView: UITextView = {
            let width = launchView.frame.width - (margin * 2)
            let textView = UITextView(frame: CGRect(x: margin, y: 0, width: width, height: 31))
            textView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
            textView.isScrollEnabled = false
            textView.isEditable = false
            
            return textView
        }()
        
        textView.text = pokemon.getPokedexEntry()
        textView.sizeToFit()
        launchView.frame.size.height = textView.frame.height
        launchView.setLaunchOrigin(to: launchOrigin)
        launchView.addSubview(textView)
    }
}


// MARK: - LaunchView Class
class LaunchView: UIView {
    
    private var parentView: UIView!
    private var dimView: UIView!
    private var launchOrigin: CGPoint!
    private var dismissOrigin: CGPoint!
    private var isIdle: Bool!
    
    var animatedDuration = 0.5
    
    
    init(parentView: UIView) {
        super.init(frame: parentView.frame)
        
        self.parentView = parentView
        self.isIdle = true
        
        // setup dimView
        self.dimView = UIView(frame: parentView.frame)
        self.dimView.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        self.dimView.alpha = 0
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        self.dimView.addGestureRecognizer(tapGesture)
        
        //setup self, LaunchView
        self.backgroundColor = UIColor.white
        
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismiss))
        swipeUpGesture.direction = .up
        self.addGestureRecognizer(swipeUpGesture)
        
        if let window = UIApplication.shared.keyWindow {
            launchOrigin = window.frame.origin
            dismissOrigin = CGPoint(x: window.frame.origin.x, y: -window.frame.height)
        }
        
        self.parentView.addSubview(self.dimView)
        self.parentView.addSubview(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setLaunchOrigin(to launchOrigin: CGPoint) {
        
        self.launchOrigin = launchOrigin
        
        //update _dismissOrigin and _dimView
        self.dismissOrigin.y = -(launchOrigin.y + self.frame.height)
        self.dimView.frame.origin.y = launchOrigin.y
        self.dimView.frame.size.height = parentView.frame.height - launchOrigin.y
    }
    
    func launch() {
        
        if self.isIdle {
            self.isIdle = false
            self.frame.origin = self.dismissOrigin
            
            UIView.animate(withDuration: animatedDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.dimView.alpha = 1
                self.frame.origin = self.launchOrigin
            }) { (Bool) in
                self.isIdle = true
            }
        }
    }
    
    func dismiss() {
        
        UIView.animate(withDuration: animatedDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.dimView.alpha = 0
            self.frame.origin = self.dismissOrigin
        }, completion: nil)
    }
}
