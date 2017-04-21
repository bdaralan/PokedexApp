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
    private var statusBarFrame: CGRect!
    private var navigationBarFrame: CGRect!
    private var launchOrigin: CGPoint!
    private var dimView: UIView!
    
    private var isViewLauncherIdle: Bool!
    
    private let margin = CONSTANTS.constrain.margin
    private let spacing = CONSTANTS.constrain.spacing
    
    
    init(parentView: UIViewController) {
        super.init()
        
        self.parentView = parentView
        self.isViewLauncherIdle = true
        
        configureLauncher()
    }
    
    
    func presentWeaknessesView(of pokemon: Pokemon) {
        
        if isViewLauncherIdle {
            isViewLauncherIdle = false
            
            addWeaknessLabels(for: pokemon)
        }
    }
    
    func presentPokedexEntryView(of pokemon: Pokemon) {
        
        if let cachedLaunchView = globalCache.object(forKey: "\(pokemon.name)launchView" as AnyObject) as? LaunchView {
            parentView.view.addSubview(cachedLaunchView)
            cachedLaunchView.launch()
        } else {
            let launchView = LaunchView(frame: dimView.frame)
            addPokedexEntry(of: pokemon, to: launchView)
            globalCache.setObject(launchView, forKey: "\(pokemon.name)launchView" as AnyObject)
            parentView.view.addSubview(launchView)
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
            let width = parentView.view.frame.width - (margin * 2)
            let textView = UITextView(frame: CGRect(x: margin, y: spacing, width: width, height: 31))
            textView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
            textView.isScrollEnabled = false
            textView.isEditable = false
            
            return textView
        }()
        
        textView.text = pokemon.getPokedexEntry()
        textView.sizeToFit()
        launchView.addSubview(textView)
        launchView.frame.size.height = textView.frame.height + spacing * 2
        launchView.setLaunchOrigin(to: launchOrigin)
    }
    
    func configureLauncher() {
        
        if let navigationBarFrame = parentView.navigationController?.navigationBar.frame {
            self.navigationBarFrame = navigationBarFrame
            self.statusBarFrame = UIApplication.shared.statusBarFrame
            
            let x = parentView.view.frame.origin.x
            let y = statusBarFrame.height + navigationBarFrame.height
            let width = parentView.view.frame.width
            let height = parentView.view.frame.height - y
            
            self.launchOrigin = CGPoint(x: x, y: y)
            
            dimView = {
                let view = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
                view.backgroundColor = UIColor(white: 0, alpha: 0.25)
                view.alpha = 0

                return view
            }()
            
            parentView.view.addSubview(dimView)
        }
    }
}


class LaunchView: UIView { // MARK: - LaunchView Class
    
    private var parentView: UIViewController!
    private var _launchOrigin: CGPoint!
    private var _dismissOrigin: CGPoint!
    
    var animatedDuration = 0.5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if let window = UIApplication.shared.keyWindow {
            _launchOrigin = window.frame.origin
            _dismissOrigin = CGPoint(x: window.frame.origin.x, y: -window.frame.height)
        }
        
        self.backgroundColor = UIColor.white
        
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismiss))
        swipeUpGesture.direction = .up
        self.addGestureRecognizer(swipeUpGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLaunchOrigin(to launchOrigin: CGPoint) {
        
        self._launchOrigin = launchOrigin
        self._dismissOrigin.y = -(self._launchOrigin.y + self.frame.height)
        self.frame.origin = self._dismissOrigin
    }
    
    func launch() {
        
        UIView.animate(withDuration: animatedDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.frame.origin = self._launchOrigin
        }, completion: nil)
    }
    
    func dismiss() { //will also remove self from superview
        
        UIView.animate(withDuration: animatedDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.frame.origin = self._dismissOrigin
        }) { (Bool) in
            self.removeFromSuperview()
        }
    }
    
    func removeAllSubViews() {
        
        for subView in self.subviews {
            subView.removeFromSuperview()
        }
    }
}
