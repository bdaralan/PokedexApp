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
    
    private var blackView: LaunchView!
    private var launchView: LaunchView! //its frame is vary by how many weaknesses a pokemon has
    
    private var animatedDuration: TimeInterval! //use for every view, unless otherwise
    private var isViewLauncherIdle: Bool!
    
    private let margin: CGFloat = 16
    private let spacing: CGFloat = 8
    
    
    // Initializer
    init(parentView: UIViewController) {
        super.init()
        
        self.parentView = parentView
        self.animatedDuration = 0.5
        self.isViewLauncherIdle = true
        
        blackView = {
            let view = LaunchView()
            view.backgroundColor = UIColor(white: 0, alpha: 0.25)
            view.alpha = 0
            return view
        }()
        
        launchView = {
            let view = LaunchView()
            view.backgroundColor = UIColor.white
            return view
        }()
        
        configureLauncher()
    }
    
    
    // MARK: - Functions
    func presentWeaknesses(of pokemon: Pokemon) {
        
        if isViewLauncherIdle {
            isViewLauncherIdle = false
            
            addWeaknessLabels(for: pokemon)
            
            launchView.frame.origin = launchView.dismissOrigin
            UIView.animate(withDuration: animatedDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.launchView.frame.origin = self.launchView.presentOrigin
            }, completion: { (Bool) in
                self.launchView.updateDismisOrigin()
                self.isViewLauncherIdle = true
            })
        }
    }
    
    func presentPokedexEntry(of pokemon: Pokemon) {
        
        if isViewLauncherIdle {
            isViewLauncherIdle = false
            
            addPokedexEntryLabels(for: pokemon)
            
            launchView.frame.origin = launchView.dismissOrigin
            UIView.animate(withDuration: animatedDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.launchView.frame.origin = self.launchView.presentOrigin
            }) { (Bool) in
                self.launchView.updateDismisOrigin()
                self.isViewLauncherIdle = true
            }
        }
    }
    
    func dismissViews() {
        
        if isViewLauncherIdle {
            isViewLauncherIdle = false
            
            UIView.animate(withDuration: animatedDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                self.blackView.alpha = 0
                self.launchView.frame.origin = self.launchView.dismissOrigin
            }, completion: { (Bool) in
                self.launchView.removeAllSubViews()
                self.isViewLauncherIdle = true
            })
        }
    }
    
    private func addWeaknessLabels(for pokemon: Pokemon) {
        
        let weaknesses = pokemon.getWeaknesses()
        var y: CGFloat = spacing
        
        for (type, effective) in weaknesses {
            let backgroundColor = COLORS.make(from: type)
            
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
            
            launchView.addSubview(typeLbl)
            launchView.addSubview(effectiveLbl)
            
            y = y + effectiveLbl.frame.height + spacing
        }
        
        launchView.frame.size = CGSize(width: parentView.view.frame.width, height: y) // MARK: - lauchView size for weaknesses
        launchView.updateDismisOrigin()
    }
    
    private func addPokedexEntryLabels(for pokemon: Pokemon) {
        
        //launchView.frame.origin = launchView.dismissOrigin
        
        let textView: UITextView = {
            let textView = UITextView(frame: CGRect(x: margin, y: 0, width: 0, height: 0))
            textView.isEditable = false
            textView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
            return textView
        }()
        
        textView.text = pokemon.getPokedexEntry()
        
        let width: CGFloat = parentView.view.frame.width - (margin * 2)
        textView.sizeToFit()
        textView.frame.size.width = width
        textView.frame.size.height = textView.contentSize.height
        launchView.addSubview(textView)
        launchView.frame.size = CGSize(width: parentView.view.frame.width, height: textView.frame.height) // MARK: - lauchView size for pokedex entry
        launchView.updateDismisOrigin()
    }
    
    private func configureLauncher() { // MARK: - Configure Launcher
        
        if let navigationBar = parentView.navigationController?.navigationBar {
            let presentOrigin = CGPoint(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBar.frame.height)
            blackView.presentOrigin = presentOrigin
            launchView.presentOrigin = presentOrigin
            
            let width: CGFloat = navigationBar.frame.width
            let height = parentView.view.frame.height - presentOrigin.y
            blackView.frame = CGRect(x: 0, y: presentOrigin.y, width: width, height: height)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissViews))
            blackView.addGestureRecognizer(tapGesture)
            
            let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissViews))
            swipeUpGesture.direction = .up
            launchView.addGestureRecognizer(swipeUpGesture)
            
            parentView.view.addSubview(blackView)
            parentView.view.addSubview(launchView)
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
    
    func updateDismisOrigin() {
        
        self._dismissOrigin.y = -(self.presentOrigin.y + self.frame.height)
    }
    
    func removeAllSubViews() {
    
        for subView in self.subviews {
            subView.removeFromSuperview()
        }
    }
}
