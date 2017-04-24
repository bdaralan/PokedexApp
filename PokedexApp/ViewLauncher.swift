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
    private var parentViewFrame: CGRect!
    private var statusBarFrame: CGRect!
    private var navigationBarFrame: CGRect!
    
    private var launchView: LaunchView!
    private var dimView: UIView!
    
    private let margin = CONSTANTS.constrain.margin
    private let spacing = CONSTANTS.constrain.spacing
    
    private let caches = NSCache<AnyObject, AnyObject>()
    
    init(parentView: UIViewController) {
        super.init()
        
        self.parentView = parentView.view
        
        // TODO: - write and else case where parentView is not a UIViewController
        if let navigationBarFrame = parentView.navigationController?.navigationBar.frame {
            self.navigationBarFrame = navigationBarFrame
            self.statusBarFrame = UIApplication.shared.statusBarFrame
            self.parentViewFrame = parentView.view.frame
            
            let x = parentViewFrame.origin.x
            let y = statusBarFrame.height + navigationBarFrame.height
            
            self.dimView = {
                let view = UIView(frame: parentViewFrame)
                view.backgroundColor = UIColor(white: 0, alpha: 0.25)
                view.alpha = 0
                
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDismiss))
                view.addGestureRecognizer(tapGesture)
                
                return view
            }()
            
            self.launchView = {
                let view = LaunchView(frame: CGRect(x: x, y: -(y + parentViewFrame.height), width: parentViewFrame.width, height: parentViewFrame.height))
                view.setLaunchOrigin(to: CGPoint(x: x, y: y))
                view.backgroundColor = UIColor.white
                
                return view
            }()
        }
        
        self.parentView.addSubview(dimView)
        self.parentView.addSubview(launchView)
    }
    
    func handleDismiss() {
        
        UIView.animate(withDuration: 0.5) {
            self.launchView.dismiss()
            self.dimView.alpha = 0
        }
    }
    
    func presentWeaknessesView(of pokemon: Pokemon) {
        
        let weaknessesView = getWeaknessView(of: pokemon)
        launchView.addSubview(weaknessesView)
        launchView.frame.size.height = weaknessesView.frame.height
        launchView.launch()
        dimView.alpha = 1
    }
    
    func presentPokedexEntryView(of pokemon: Pokemon) {
        
        let pokedexEntryView = getPokedexEntryView(of: pokemon)
        launchView.addSubview(pokedexEntryView)
        launchView.frame.size.height = pokedexEntryView.frame.height
        launchView.launch()
        dimView.alpha = 1
    }
    
    func getPokedexEntryView(of pokemon: Pokemon) -> UIView {
        
        let textView: UITextView!
        
        if let cachedTextView = globalCache.object(forKey: "pokedexEntry\(pokemon.id)" as AnyObject) as? UITextView {
            textView = cachedTextView
        } else {
            textView = {
                let width = launchView.frame.width - (margin * 2)
                let textView = UITextView(frame: CGRect(x: margin, y: 0, width: width, height: 31))
                textView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
                textView.isScrollEnabled = false
                textView.isEditable = false
                
                return textView
            }()
            
            textView.text = pokemon.getPokedexEntry()
            textView.sizeToFit()
            textView.frame.size.width = launchView.frame.width - margin * 2
            
            globalCache.setObject(textView, forKey: "pokedexEntry\(pokemon.id)" as AnyObject)
        }
        
        let pokedexEntryView = UIView(frame: CGRect(x: 0, y: 0, width: launchView.frame.width, height: textView.frame.height))
        pokedexEntryView.addSubview(textView)
        
        return pokedexEntryView
    }
    
    func getWeaknessView(of pokemon: Pokemon) -> UIView {
        
        var y: CGFloat = spacing //will keep increasing as more weakness labels are added
        
        let weaknessesView = UIView(frame: CGRect(x: 0, y: 0, width: launchView.frame.width, height: y))
        var weaknessLabels = [UILabel]()
        
        // TODO: - fix this repeated calculation when caching
        if let cachedWeaknessLabels = globalCache.object(forKey: "weaknessLabelsForType\(pokemon.primaryType)\(pokemon.secondaryType)" as AnyObject) as? [UILabel] {
            weaknessLabels = cachedWeaknessLabels
            
            for i in 0 ..< weaknessLabels.count / 2 {
                y = y + weaknessLabels[i].frame.height + spacing
            }
        } else if let cachedWeaknessLabels = globalCache.object(forKey: "weaknessLabelsForType\(pokemon.secondaryType)\(pokemon.primaryType)" as AnyObject) as? [UILabel] {
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
                
                weaknessLabels.append(typeLbl)
                weaknessLabels.append(effectiveLbl)
                
                y = y + typeLbl.frame.height + spacing
            }
            
            globalCache.setObject(weaknessLabels as AnyObject, forKey: "weaknessLabelsForType\(pokemon.primaryType)\(pokemon.secondaryType)" as AnyObject)
        }
        
        weaknessesView.frame.size.height = y
        
        for weakness in weaknessLabels {
            weaknessesView.addSubview(weakness)
        }
        
        return weaknessesView
    }
}


// MARK: - LaunchView Class
class LaunchView: UIView {
    
    private var isIdle: Bool!
    private var launchOrigin: CGPoint!
    
    private var dismissOrigin: CGPoint {
        
        return CGPoint(x: launchOrigin.x, y: -(launchOrigin.y + self.frame.height))
    }
    
    var animatedDuration = 0.5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isIdle = true
        
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismiss))
        swipeUpGesture.direction = .up
        self.addGestureRecognizer(swipeUpGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setLaunchOrigin(to launchOrigin: CGPoint) {
        
        self.launchOrigin = launchOrigin
    }
    
    func launch() {
        
        if self.isIdle {
            self.isIdle = false
            self.frame.origin = self.dismissOrigin
            
            UIView.animate(withDuration: animatedDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.frame.origin = self.launchOrigin
            }) { (Bool) in
                self.isIdle = true
            }
        }
    }
    
    func dismiss() {
        
        UIView.animate(withDuration: animatedDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.frame.origin = self.dismissOrigin
        }) { (Bool) in
            for subview in self.subviews {
                subview.removeFromSuperview()
            }
        }
    }
}
