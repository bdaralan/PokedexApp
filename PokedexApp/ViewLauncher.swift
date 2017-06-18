//
//  ViewLauncher.swift
//  PokedexApp
//
//  Created by Dara on 6/17/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

protocol ViewLauncherDelegate: class {
 
    func viewLauncherDidDismiss()
}



class ViewLauncher: UIView, Animatable, CAAnimationDelegate {
    
    weak var delegate: ViewLauncherDelegate?
    
    var launchView = AnimatableUIView()
    
    var dimView = AnimatableUIView()
    
    var animationDuration: TimeInterval = 0.75
    
    var launchValue: NSValue? // must anually set
    
    var dismissValue: NSValue? // same as launchValue

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(dimView)
        self.addSubview(launchView)
        
        self.awakeFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // set self properties
        self.backgroundColor = UIColor.clear
        //self.clipsToBounds = true
        
        // set lauchView properties
        self.launchView.backgroundColor = UIColor.Pokemon.Type.psychic
        self.launchView.layer.cornerRadius = 21
        
        // set dimView properties
        self.dimView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        // apply functionlaities
        self.addDismissGestures()
        self.applyConstraints()
    }
    
    
    
    // MARK: - Override superclass properties
    
    override func didMoveToSuperview() {
        
        guard let superview = superview else { return }
        self.layoutIfNeeded()
        self.launchValue = NSValue(cgPoint: CGPoint(x: superview.center.x, y: self.launchView.center.y))
        self.dismissValue = NSValue(cgPoint: CGPoint(x: superview.center.x * 3, y: self.launchView.center.y))
    }
    
    
    
    // MARK: - Protocol
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        self.removeFromSuperview()
    }
    
    
    
    // MARK: - Methods
    
    /// Send `launchView` to the center of `self.superview` and fade-in `dimView`
    func launch() {
        
        guard let launchValue = self.launchValue, let dismissValue = self.dismissValue else {
            print("called ViewLauncher.launch() before set launchValue and dismissValue")
            return
        }
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            // create animations
            let positionAnimation = self.createPositionAnimation(fromValue: dismissValue, toValue: launchValue, duration: self.animationDuration)
            let fadeInAnimation = self.createFadeInAnimation(duration: self.animationDuration)
            
            // set final positions
            self.launchView.center = launchValue.cgPointValue
            self.dimView.alpha = 1
            
            DispatchQueue.main.async {
                // start animations
                self.launchView.layer.add(positionAnimation, forKey: "position")
                self.dimView.layer.add(fadeInAnimation, forKey: "opacity")
            }
        }
    }
    
    /// Send `launchView` off screen self and fade-out `dimView`
    func dismiss() {
        
        guard let launchValue = self.launchValue, let dismissValue = self.dismissValue else {
            print("called ViewLauncher.dismiss() before set launchValue and dismissValue")
            return
        }
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            // create animations
            let positionAnimation = self.createPositionAnimation(fromValue: launchValue, toValue: dismissValue, duration: self.animationDuration)
            let fadeOutAnimation = self.createFadeOutAnimation(duration: self.animationDuration)
            
            fadeOutAnimation.delegate = self //set delegate so `self` can remove itself from superview after dismiss animations end
            
            // set final positions
            self.launchView.center = dismissValue.cgPointValue
            self.dimView.alpha = 0
            
            DispatchQueue.main.async {
                // start animations
                self.launchView.layer.add(positionAnimation, forKey: "position")
                self.dimView.layer.add(fadeOutAnimation, forKey: "opacity")
            }
        }
    }
}



// MARK: - Helper functions

extension ViewLauncher {
    
    /// Add dimiss gestures to `launchView` and `dimView`
    func addDismissGestures() {
        
        let swipeToDismiss = UISwipeGestureRecognizer(target: self, action: #selector(dismiss))
        swipeToDismiss.direction = .right
        launchView.addGestureRecognizer(swipeToDismiss)
        
        let tapToDimiss = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        dimView.addGestureRecognizer(tapToDimiss)
    }
    
    /// Applying constraints to `launchView` and `dimView`
    func applyConstraints() {

        let views = [
            "launchView": launchView,
            "dimView": dimView
        ]
        
        launchView.translatesAutoresizingMaskIntoConstraints = false
        dimView.translatesAutoresizingMaskIntoConstraints = false
        
        let launchViewHConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[launchView]-16-|", options: [], metrics: nil, views: views)
        let launchViewVConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[launchView(90)]", options: [], metrics: nil, views: views)
        let dimViewHConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[dimView]|", options: [], metrics: nil, views: views)
        let dimViewVConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[dimView]|", options: [], metrics: nil, views: views)

        self.addConstraints(launchViewHConstraints + launchViewVConstraints + dimViewHConstraints + dimViewVConstraints)
    }
}
