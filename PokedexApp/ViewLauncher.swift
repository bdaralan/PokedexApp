////
////  ViewLauncher.swift
////  PokedexApp
////
////  Created by Dara on 4/10/17.
////  Copyright © 2017 iDara09. All rights reserved.
////
//
//import UIKit
//
//@objc protocol ViewLauncherDelegate {
//    
//    @objc optional func viewLauncher(willLaunch launchOrigin: CGPoint)
//    
//    @objc optional func viewLauncher(didLaunch launchOrigin: CGPoint)
//    
//    @objc optional func viewLauncher(willDismiss dismissOrigin: CGPoint)
//    
//    @objc optional func viewLauncher(didDismiss dismissOrigin: CGPoint)
//}
//
//
//
//
//// TODO: - Allow launcView to be size to any width, beside keyWindow width
//
//class ViewLauncher: NSObject {
//    
//    weak var delegate: ViewLauncherDelegate?
//    
//    private var _launchView: UIView!
//    private var _dimView: UIView!
//    
//    private var _launchOrigin: CGPoint!
//    private var _swipeToDismissDirection: UISwipeGestureRecognizerDirection!
//    
//    var animatedDuration: TimeInterval = 0.5
//    var isRemoveSubviewsAfterDimissed: Bool = true
//    var isIdle: Bool = true
//    
//    var frame: CGRect {
//        set { _launchView.frame = newValue }
//        get { return _launchView.frame }
//    }
//    
//    var dismissOrigin: CGPoint {
//        if _swipeToDismissDirection == .up {
//            return CGPoint(x: _launchOrigin.x, y: -(_launchOrigin.y + _launchView.frame.height))
//            
//        } else if _swipeToDismissDirection == .right {
//            return CGPoint(x: _launchOrigin.x + _launchView.frame.width, y: _launchOrigin.y)
//            
//        } else if _swipeToDismissDirection == .left {
//            return CGPoint(x: -(_launchOrigin.x + _launchView.frame.width), y: _launchOrigin.y)
//            
//        } else { // .down
//            return CGPoint(x: _launchOrigin.x, y: (_launchOrigin.y + _launchView.frame.height))
//        }
//    }
//    
//    
//    
//    
//    init(launchViewFrame: CGRect, dimViewFrame: CGRect, swipeToDismissDirection: UISwipeGestureRecognizerDirection) {
//        super.init()
//        
//        self._swipeToDismissDirection = swipeToDismissDirection
//        self._launchOrigin = launchViewFrame.origin
//        
//        self._launchView = {
//            let view = UIView(frame: launchViewFrame)
//            view.backgroundColor = UIColor.white
//            view.layer.shadowColor = UIColor.black.cgColor
//            view.layer.shadowOffset = CGSize(width: 0, height: 3)
//            view.layer.shadowOpacity = 0.3
//            view.layer.shadowRadius = 3
//            
//            let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismiss(duration:)))
//            swipeUpGesture.direction = swipeToDismissDirection
//            view.addGestureRecognizer(swipeUpGesture)
//            
//            return view
//        }()
//        
//        self._launchView.frame.origin = self.dismissOrigin
//        
//        self._dimView = {
//            let view = UIView(frame: dimViewFrame)
//            view.backgroundColor = UIColor(white: 0, alpha: 0.1)
//            view.alpha = 0
//            
//            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismiss(duration:)))
//            view.addGestureRecognizer(tapGesture)
//            
//            return view
//        }()
//    }
//    
//    
//    /** Convenience init.
//        Use this to quickly initialize ViewLauncer when there is a NavigationController
//     */
//    convenience init(swipeToDismissDirection: UISwipeGestureRecognizerDirection) {
//        
//        let statusBarFrame = UIApplication.shared.statusBarFrame
//        let navBarFrame = UINavigationController().navigationBar.frame
//        let window = UIWindow()
//        
//        let y = statusBarFrame.height + navBarFrame.height
//        let width = window.frame.width
//        let height = window.frame.height - y
//        
//        let launchViewFrame = CGRect(x: 0, y: y + 0.5, width: width, height: height)
//        let dimViewFrame = CGRect(x: 0, y: y, width: width, height: window.frame.height)
//        
//        self.init(launchViewFrame: launchViewFrame, dimViewFrame: dimViewFrame, swipeToDismissDirection: swipeToDismissDirection)
//    }
//    
//    
//    
//    
//    func setSuperview(_ superview: UIView) {
//        
//        superview.addSubview(self._dimView)
//        superview.addSubview(self._launchView)
//    }
//    
//    func removeFromSuperview() {
//        
//        self._dimView.removeFromSuperview()
//        self._launchView.removeFromSuperview()
//    }
//    
//    func addSubview(_ subview: UIView) {
//        
//        let spacing = subview.frame.origin.y
//        _launchView.frame.size.height = subview.frame.height + spacing * 2
//        
//        _launchView.addSubview(subview)
//    }
//    
//    func addSubviews(_ subviews: [UIView]) {
//        
//        var spacing: CGFloat = 0
//        
//        if subviews[0].frame.origin.y == 8 { spacing = 8 }
//        
//        for view in subviews {
//            view.frame.origin.y += spacing
//            _launchView.addSubview(view)
//        }
//        
//        if let lastView = subviews.last {
//            _launchView.frame.size.height = lastView.frame.origin.y + lastView.frame.height + subviews[0].frame.origin.y
//        }
//    }
//    
//    func launch(duration: TimeInterval = 0, withHeight height: CGFloat = 0) {
//        
//        if self.isIdle {
//            self.isIdle = false
//            
//            if height > 0 { self._launchView.frame.size.height = height }
//            
//            var duration = duration
//            if duration == 0 { duration = animatedDuration }
//            
//            self.delegate?.viewLauncher?(willLaunch: self._launchOrigin)
//            
//            self._launchView.frame.origin = dismissOrigin
//            
//            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//                self._dimView.alpha = 1
//                self._launchView.frame.origin = self._launchOrigin
//            }) { (Bool) in
//                self.isIdle = true
//                self.delegate?.viewLauncher?(didLaunch: self._launchOrigin)
//            }
//        }
//    }
//    
//    func dismiss(duration: TimeInterval = 0) {
//        
//        if self.isIdle {
//            self.isIdle = false
//            
//            var duration = duration
//            if duration == 0 { duration = animatedDuration }
//            
//            self.delegate?.viewLauncher?(willDismiss: self.dismissOrigin)
//            
//            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//                self._dimView.alpha = 0
//                self._launchView.frame.origin = self.dismissOrigin
//            }) { (Bool) in
//                if self.isRemoveSubviewsAfterDimissed {
//                    for subview in self._launchView.subviews {
//                        subview.removeFromSuperview()
//                    }
//                }
//
//                self.isIdle = true
//                self.delegate?.viewLauncher?(didDismiss: self.dismissOrigin)
//            }
//        }
//    }
//}
//
//
//
//
//// MARK: - ViewLauncher Extention
//extension ViewLauncher {
//    
//    func weaknessLabels(of pokemon: Pokemon) -> [TypeUILabel] {
//        
//        let spacing = Constant.Constrain.spacing
//        let margin = Constant.Constrain.margin
//        var y: CGFloat = spacing //will keep increasing as more weakness labels are added
//    
//        var weaknessLabels = [TypeUILabel]()
//        
//
//        if let cachedWeaknessLabels = globalCache.object(forKey: "cachedWeaknessLabels\(pokemon.primaryType)\(pokemon.secondaryType)" as AnyObject) as? [TypeUILabel] {
//        
//            weaknessLabels = cachedWeaknessLabels
//            
//        } else if let cachedWeaknessLabels = globalCache.object(forKey: "cachedWeaknessLabels\(pokemon.secondaryType)\(pokemon.primaryType)" as AnyObject) as? [TypeUILabel] {
//            
//            weaknessLabels = cachedWeaknessLabels
//            
//        } else {
//            let weaknesses = pokemon.weaknesses
//            
//            for (type, effective) in weaknesses {
//                
//                let typeLbl: TypeUILabel = {
//                    let label = TypeUILabel()
//                    label.frame.origin.x = margin
//                    label.frame.origin.y = y
//                    label.text = type
//                    return label
//                }()
//                
//                let effectiveLbl: TypeUILabel = {
//                    let label = TypeUILabel()
//                    label.frame.origin.x = margin + label.frame.width + spacing
//                    label.frame.origin.y = y
//                    label.text = "\(effective)x"
//                    label.backgroundColor = typeLbl.backgroundColor
//                    
//                    // MARK: - Pokemon's weaknesses effective width
//                    if effective == "1/4" {
//                        label.frame.size.width = label.frame.height * 2
//                    } else if effective == "1/2" {
//                        label.frame.size.width = label.frame.height * 4
//                    } else if effective == "2" {
//                        label.frame.size.width = label.frame.height * 8
//                    } else if effective == "4" {
//                        label.frame.size.width = self.frame.width - label.frame.width - spacing - (margin * 2)
//                    } else if effective == "0" { // "0"
//                        label.frame.size.width = label.frame.height * 2
//                        label.textAlignment = .left
//                        label.font = UIFont(name: "\(label.font.fontName)-Bold", size: label.font.pointSize)
//                        label.textColor = typeLbl.backgroundColor
//                        label.backgroundColor = UIColor.clear
//                    }
//                    
//                    return label
//                }()
//                
//                weaknessLabels.append(typeLbl)
//                weaknessLabels.append(effectiveLbl)
//                
//                y = y + typeLbl.frame.height + spacing
//            }
//            
//            globalCache.setObject(weaknessLabels as AnyObject, forKey: "cachedWeaknessLabels\(pokemon.primaryType)\(pokemon.secondaryType)" as AnyObject)
//        }
//        
//        return weaknessLabels
//    }
//    
//    func makeTextView(withText text: String) -> UITextView {
//        
//        let textView: UITextView!
//        
//        let cachedTextView = "cachedLaunchViewTextView"
//        
//        let margin = Constant.Constrain.margin
//        let width = self.frame.width - (margin * 2)
//        
//        if let cachedTextView = globalCache.object(forKey: cachedTextView as AnyObject) as? UITextView {
//            textView = cachedTextView
//            textView.text = text
//        } else {
//            textView = {
//                let textView = UITextView(frame: CGRect(x: margin, y: 8, width: width, height: 31))
//                textView.font = Constant.Font.appleSDGothicNeoRegular
//                textView.isScrollEnabled = false
//                textView.isEditable = false
//                
//                return textView
//            }()
//            
//            globalCache.setObject(textView, forKey: cachedTextView as AnyObject)
//        }
//        
//        textView.text = text
//        textView.sizeToFit()
//        textView.frame.size.width = width
//        
//        return textView
//    }
//}
