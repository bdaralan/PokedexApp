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
    private var textView: UITextView!
    
    private var animatedDuration: TimeInterval! //use for every view, unless otherwise
    private var isViewLauncherIdle: Bool!
    
    private let margin = CONSTANTS.constrain.margin
    private let spacing = CONSTANTS.constrain.spacing
    
    
    // Initializer
    init(parentView: UIViewController) {
        super.init()
        
        self.parentView = parentView
        self.animatedDuration = 0.5
        self.isViewLauncherIdle = true
        
        configureLauncher()
    }
    
    
    // MARK: - Functions
    func presentWeaknesses(of pokemon: Pokemon) {
        
        if isViewLauncherIdle {
            isViewLauncherIdle = false
            
            addWeaknessLabels(for: pokemon)
            
            launchView.updateDismissOrigin()
            launchView.frame.origin = launchView.dismissOrigin
            UIView.animate(withDuration: animatedDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.launchView.frame.origin = self.launchView.launchOrigin
            }, completion: { (Bool) in
                self.isViewLauncherIdle = true
            })
        }
    }
    
    func presentPokedexEntry(of pokemon: Pokemon) {
        
        if isViewLauncherIdle {
            isViewLauncherIdle = false
            
            addPokedexEntryLabels(for: pokemon)
            
            launchView.updateDismissOrigin()
            launchView.frame.origin = launchView.dismissOrigin
            UIView.animate(withDuration: animatedDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.launchView.frame.origin = self.launchView.launchOrigin
            }) { (Bool) in
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
        
        // MARK: - lauchView height for pokemon's weaknesses
        launchView.frame.size.height = y
    }
    
    private func addPokedexEntryLabels(for pokemon: Pokemon) {
        
        textView.text = pokemon.getPokedexEntry()
        textView.sizeToFit()
        
        // MARK: - lauchView height for pokemon's pokedex entry
        launchView.frame.size.height = textView.frame.height
        launchView.addSubview(textView)
    }
    
    private func configureLauncher() {
        
        if let navigationBar = parentView.navigationController?.navigationBar {
            let launchOrigin = CGPoint(x: 0, y: UIApplication.shared.statusBarFrame.height + navigationBar.frame.height)
            let x = launchOrigin.x
            let y = launchOrigin.y
            let width = parentView.view.frame.width
            let height = parentView.view.frame.height - y
            
            blackView = {
                let view = LaunchView()
                view.launchOrigin = launchOrigin
                view.frame = CGRect(x: x, y: y, width: width, height: height)
                view.backgroundColor = UIColor(white: 0, alpha: 0.25)
                view.alpha = 0
                
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissViews))
                view.addGestureRecognizer(tapGesture)
                
                return view
            }()
            
            launchView = {
                let view = LaunchView()
                view.launchOrigin = launchOrigin
                view.frame.size.width = width
                view.backgroundColor = UIColor.white
                
                let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissViews))
                swipeUpGesture.direction = .up
                view.addGestureRecognizer(swipeUpGesture)
                
                return view
            }()
            
            textView = {
                let width = width - (margin * 2)
                let textView = UITextView(frame: CGRect(x: margin, y: 0, width: width, height: 31))
                textView.contentSize = textView.frame.size
                textView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
                textView.isScrollEnabled = false
                textView.isEditable = false
                
                return textView
            }()
            
            parentView.view.addSubview(blackView)
            parentView.view.addSubview(launchView)
        }
    }
}

private class LaunchView: UIView {
    
    private var _launchOrigin: CGPoint!
    private var _dismissOrigin: CGPoint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if let window = UIApplication.shared.keyWindow {
            _launchOrigin = CGPoint(x: 0, y: 0)
            _dismissOrigin = CGPoint(x: 0, y: -(window.frame.height))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var launchOrigin: CGPoint {
        
        set { self._launchOrigin = newValue }
        get { return self._launchOrigin }
    }
    
    var dismissOrigin: CGPoint {
        
        set { self._dismissOrigin = newValue }
        get { return self._dismissOrigin }
    }
    
    func updateDismissOrigin() {
        
        self._dismissOrigin.y = -(self.launchOrigin.y + self.frame.height)
    }
    
    func removeAllSubViews() {
        
        for subView in self.subviews {
            subView.removeFromSuperview()
        }
    }
}
