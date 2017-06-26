//
//  ViewLauncher.swift
//  PokedexApp
//
//  Created by Dara on 6/17/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

protocol ViewLauncherDelegate: class {
    
    func viewLauncherWillDismiss(viewlauncher: ViewLauncher)
}

class ViewLauncher: UIView, CAAnimationDelegate {
    
    weak var delegate: ViewLauncherDelegate?
    
    var launchView = AnimatableUIView()
    
    var dimView = AnimatableUIView()
    
    var animationDuration: TimeInterval = 0.5
    
    var timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    
    var launchValue: NSValue! // will be computed when call launch() or dismiss()
    
    var dismissValue: NSValue! // same as launchValue
    
    private var isDismissing: Bool!

    
    
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
        
        // add launchView and dimView to self
        self.addSubview(dimView)
        self.addSubview(launchView)
        
        // apply functionlaities
        self.addLaunchViewDimViewDismissGestures()
        self.addLaunchViewDimViewConstraints()
    }

    
    
    // MARK: - Delegate
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if isDismissing {
            self.alpha = 0
        }
    }
    
    
    
    /// Send `launchView` to the center of `self.superview` and fade-in `dimView`
    func launch() {
    
        // flag isLaunching
        self.isDismissing = false
        
        // estimate launch and dimiss position
        computeLaunchDimissValues(superview: self.superview)
        
        // create animations
        let positionAnimation = createPositionAnimation(fromValue: dismissValue, toValue: launchValue, duration: animationDuration, timingFunction: timingFunction)
        let fadeInAnimation = createFadeInAnimation(duration: animationDuration, timingFunction: timingFunction)
        fadeInAnimation.delegate = self
        
        // set final positions after launch animation
        self.alpha = 1
        self.dimView.alpha = 1
        self.launchView.center = launchValue.cgPointValue
        
        // start animations
        self.launchView.layer.add(positionAnimation, forKey: "position")
        self.dimView.layer.add(fadeInAnimation, forKey: "opacity")
    }
    
    /// Send `launchView` off screen self and fade-out `dimView`
    func dismiss(animated: Bool) { 
        
        // flag isLaunching
        self.isDismissing = true
        
        // estimate launch and dimiss position
        computeLaunchDimissValues(superview: self.superview)
        
        // delegate
        delegate?.viewLauncherWillDismiss(viewlauncher: self)
        
        if animated {
            // create animations
            let positionAnimation = createPositionAnimation(fromValue: launchValue, toValue: dismissValue, duration: animationDuration, timingFunction: timingFunction)
            let fadeOutAnimation = createFadeOutAnimation(duration: animationDuration, timingFunction: timingFunction)
            fadeOutAnimation.delegate = self
            
            // set final positions after dismiss animation
            self.dimView.alpha = 0
            self.launchView.center = dismissValue.cgPointValue
            
            // start animations
            self.launchView.layer.add(positionAnimation, forKey: "position")
            self.dimView.layer.add(fadeOutAnimation, forKey: "opacity")
        
        } else {
            // set final positions after dismiss animation
            self.alpha = 0
            self.dimView.alpha = 0
            self.launchView.center = dismissValue.cgPointValue
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
        
        let swipeToDismiss = UISwipeGestureRecognizer(target: self, action: #selector(handleDismissCalledBySelector))
        swipeToDismiss.direction = .right
        launchView.addGestureRecognizer(swipeToDismiss)
        
        let tapToDimiss = UITapGestureRecognizer(target: self, action: #selector(handleDismissCalledBySelector))
        dimView.addGestureRecognizer(tapToDimiss)
    }
    
    /// Dismiss function used by selector
    func handleDismissCalledBySelector() {
        
        dismiss(animated: true)
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
