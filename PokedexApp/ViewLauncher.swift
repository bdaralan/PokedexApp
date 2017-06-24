//
//  ViewLauncher.swift
//  PokedexApp
//
//  Created by Dara on 6/17/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class ViewLauncher: UIView, Animatable, CAAnimationDelegate {
    
    var launchView = AnimatableUIView()
    
    var dimView = AnimatableUIView()
    
    var animationDuration: TimeInterval = 0.5
    
    var launchValue: NSValue? // must anually set
    
    var dismissValue: NSValue? // same as launchValue
    
    private var isLaunching = false

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.awakeFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // set self properties
        self.backgroundColor = UIColor.clear
        self.alpha = 1
        self.clipsToBounds = true
        
        // set lauchView properties
        self.launchView.backgroundColor = UIColor.white
        self.launchView.layer.cornerRadius = 21
        
        // set dimView properties
        self.dimView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    override func didMoveToSuperview() {
        
        // add launchView and dimView to self
        self.addSubview(dimView)
        self.addSubview(launchView)
        
        // apply functionlaities
        self.addLaunchViewDimViewDismissGestures()
        self.addLaunchViewDimViewConstraints()
        
        // estimate dimiss position
        computeLaunchDimissValues(superview: self.superview)
    }
    
    
    
    // MARK: - Protocol
    
    func animationDidStart(_ anim: CAAnimation) {
        
        if isLaunching, let launchValue = launchValue {
            // set final positions after launch animation
            self.launchView.center = launchValue.cgPointValue
            self.dimView.alpha = 1
            self.alpha = 1
            
        }
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
         if !isLaunching, let dismissValue = dismissValue {
            // set final positions after dismiss animation
            self.launchView.center = dismissValue.cgPointValue
            self.dimView.alpha = 0
            self.alpha = 0
        }
    }

    
    
    // MARK: - Methods
    
    /// Send `launchView` to the center of `self.superview` and fade-in `dimView`
    func launch() {
    
        if let launchValue = self.launchValue, let dismissValue = self.dismissValue {
            // mark isLaunching to true
            self.isLaunching = true
            
            // create animations
            let positionAnimation = self.createPositionAnimation(fromValue: dismissValue, toValue: launchValue, duration: self.animationDuration)
            let fadeInAnimation = self.createFadeInAnimation(duration: self.animationDuration)
            fadeInAnimation.delegate = self //set delegate to call animationDidStop
            
            // start animations
            self.launchView.layer.add(positionAnimation, forKey: "position")
            self.dimView.layer.add(fadeInAnimation, forKey: "opacity")
        
        } else {
            print("called ViewLauncher.launch() before set launchValue and dismissValue")
        }
    }
    
    /// Send `launchView` off screen self and fade-out `dimView`
    func dismiss() {
        
        if let launchValue = self.launchValue, let dismissValue = self.dismissValue {
            // mark isLaunching to false
            self.isLaunching = false
            
            // create animations
            let positionAnimation = self.createPositionAnimation(fromValue: launchValue, toValue: dismissValue, duration: self.animationDuration)
            let fadeOutAnimation = self.createFadeOutAnimation(duration: self.animationDuration)
            fadeOutAnimation.delegate = self //set delegate to call animationDidStop
            
            // start animations
            self.launchView.layer.add(positionAnimation, forKey: "position")
            self.dimView.layer.add(fadeOutAnimation, forKey: "opacity")
        
        } else {
            print("called ViewLauncher.dismiss() before set launchValue and dismissValue")
        }
    }
}



// MARK: - Helper functions

extension ViewLauncher {
    
    func computeLaunchDimissValues(superview: UIView?) {
        
        guard let superview = superview else { return }
        self.launchValue = NSValue(cgPoint: CGPoint(x: superview.center.x, y: self.launchView.center.y))
        self.dismissValue = NSValue(cgPoint: CGPoint(x: superview.center.x * 3, y: self.launchView.center.y))
    }
    
    /// Add dimiss gestures to `launchView` and `dimView`
    func addLaunchViewDimViewDismissGestures() {
        
        let swipeToDismiss = UISwipeGestureRecognizer(target: self, action: #selector(dismiss))
        swipeToDismiss.direction = .right
        launchView.addGestureRecognizer(swipeToDismiss)
        
        let tapToDimiss = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        dimView.addGestureRecognizer(tapToDimiss)
    }
    
    /// Applying constraints to `launchView` and `dimView`
    func addLaunchViewDimViewConstraints() {

        let views = ["launchView": launchView, "dimView": dimView]
        
        launchView.translatesAutoresizingMaskIntoConstraints = false
        dimView.translatesAutoresizingMaskIntoConstraints = false
                
        let launchViewHConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[launchView]-16-|", options: [], metrics: nil, views: views)
        let launchViewVConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[launchView]", options: [], metrics: nil, views: views)
        
        let dimViewHConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[dimView]|", options: [], metrics: nil, views: views)
        let dimViewVConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[dimView]|", options: [], metrics: nil, views: views)

        self.addConstraints(launchViewHConstraints + launchViewVConstraints + dimViewHConstraints + dimViewVConstraints)
    }
}
