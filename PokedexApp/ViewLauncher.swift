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
        
        addWeaknessLabels(for: pokemon)
    }
    
    func presentPokedexEntryView(of pokemon: Pokemon) {
        print("present", parentView.subviews.count)
        if let cachedLaunchView = globalCache.object(forKey: "launchView\(pokemon.name)" as AnyObject) as? LaunchView {
            print("cache")
            cachedLaunchView.launch()
        } else {
            let launchView = LaunchView(parentView: parentView)
            addPokedexEntry(of: pokemon, to: launchView)
            globalCache.setObject(launchView, forKey: "launchView\(pokemon.name)" as AnyObject)
            launchView.launch()
        }
    }
    
    func addWeaknessLabels(for pokemon: Pokemon) {
        
        //        let weaknesses = pokemon.getWeaknesses()
        //        var y: CGFloat = spacing //will keep increasing as more weakness labels are added
        //
        //        for (type, effective) in weaknesses {
        //            let backgroundColor = COLORS.make(from: type)
        //
        //            let typeLbl: TypeUILabel = {
        //                let label = TypeUILabel()
        //                label.awakeFromNib()
        //                label.frame.origin.x = margin
        //                label.frame.origin.y = y
        //                label.backgroundColor = backgroundColor
        //                label.text = type
        //                return label
        //            }()
        //
        //            let effectiveLbl: TypeUILabel = {
        //                let label = TypeUILabel()
        //                label.awakeFromNib()
        //                label.frame.origin.x = margin + label.frame.width + spacing
        //                label.frame.origin.y = y
        //
        //                // MARK: - Pokemon's weaknesses effective width
        //                if effective == "1/4" {
        //                    label.frame.size.width = label.frame.height * 2
        //                } else if effective == "1/2" {
        //                    label.frame.size.width = label.frame.height * 4
        //                } else if effective == "2" {
        //                    label.frame.size.width = label.frame.height * 8
        //                } else if effective == "4" {
        //                    label.frame.size.width = parentView.view.frame.width - label.frame.width - spacing - (margin * 2)
        //                } else if effective == "0" { // "0"
        //                    label.frame.size.width = label.frame.height * 2
        //                }
        //
        //                label.text = "\(effective)x"
        //
        //                if effective == "0" {
        //                    label.textAlignment = .left
        //                    label.font = UIFont(name: "\(label.font.fontName)-Bold", size: label.font.pointSize)
        //                    label.textColor = backgroundColor
        //                    label.backgroundColor = UIColor.white
        //                } else {
        //                    label.backgroundColor = backgroundColor
        //                }
        //
        //                return label
        //            }()
        //
        //            ///launchView.addSubview(typeLbl)
        //            ///launchView.addSubview(effectiveLbl)
        //
        //            y = y + effectiveLbl.frame.height + spacing
        //        }
        //
        //        // MARK: - lauchView height for pokemon's weaknesses
        //        ///launchView.frame.size.height = y
    }
    
    func addPokedexEntry(of pokemon: Pokemon, to launchView: LaunchView) {
        
        let textView: UITextView = {
            let width = launchView.frame.width - (margin * 2)
            let textView = UITextView(frame: CGRect(x: margin, y: spacing, width: width, height: 31))
            textView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
            textView.isScrollEnabled = false
            textView.isEditable = false
            
            return textView
        }()
        
        textView.text = pokemon.getPokedexEntry()
        textView.sizeToFit()
        launchView.frame.size.height = textView.frame.height + spacing * 2
        launchView.setLaunchOrigin(to: launchOrigin)
        launchView.addSubview(textView)
    }
}


class LaunchView: UIView { // MARK: - LaunchView Class
    
    private var _parentView: UIView!
    private var _dimView: UIView!
    private var _launchOrigin: CGPoint!
    private var _dismissOrigin: CGPoint!
    private var _isIdle: Bool!
    
    var animatedDuration = 1.0
    
    init(parentView: UIView) {
        super.init(frame: parentView.frame)
        
        self._parentView = parentView
        self._isIdle = true
        
        // setup dimView
        self._dimView = UIView(frame: parentView.frame)
        self._dimView.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        self._dimView.alpha = 0
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        self._dimView.addGestureRecognizer(tapGesture)
        
        //setup self, LaunchView
        self.backgroundColor = UIColor.white
        self.alpha = 0
        
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismiss))
        swipeUpGesture.direction = .up
        self.addGestureRecognizer(swipeUpGesture)
        
        if let window = UIApplication.shared.keyWindow {
            _launchOrigin = window.frame.origin
            _dismissOrigin = CGPoint(x: window.frame.origin.x, y: -window.frame.height)
        }
        
        //self._parentView.addSubview(self._dimView)
        //self._parentView.addSubview(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLaunchOrigin(to launchOrigin: CGPoint) {
        
        self._launchOrigin = launchOrigin
        self._dismissOrigin.y = -(launchOrigin.y + self.frame.height)
        self._dimView.frame.origin.y = launchOrigin.y
        self._dimView.frame.size.height = _parentView.frame.height - launchOrigin.y
    }
    
    func launch() {
        
        if self._isIdle {
            self._isIdle = false
            self.frame.origin = self._dismissOrigin
            
            self._parentView.addSubview(self._dimView)
            self._parentView.addSubview(self)
            print(self._parentView.subviews.count)
            
            UIView.animate(withDuration: animatedDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self._dimView.alpha = 1
                self.alpha = 1
                self.frame.origin = self._launchOrigin
            }) { (Bool) in
                self._isIdle = true
            }
        }
    }
    
    func dismiss() { //will also remove self from superview
        
        UIView.animate(withDuration: animatedDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self._dimView.alpha = 0
            self.alpha = 0
            self.frame.origin = self._dismissOrigin
        }) { (Bool) in
            self._dimView.removeFromSuperview()
            self.removeFromSuperview()
            print("removed from superview", self._parentView.subviews.count)
        }
    }
}
