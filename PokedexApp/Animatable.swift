//
//  Animatable.swift
//  PokedexApp
//
//  Created by Dara on 6/17/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

protocol Animatable: class {}

// MARK: - Methods for creating animations

extension Animatable {
    
    func createFadeInAnimation(values: [Any] = [0, 0.25, 0.5, 0.75, 1], keyTimes: [NSNumber] = [0, 0.25, 0.5, 0.75, 1], duration: TimeInterval = 0.75, timingFunction: CAMediaTimingFunction) -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "opacity")
        animation.values = values
        animation.keyTimes = keyTimes
        animation.duration = duration
        animation.timingFunction = timingFunction
        return animation
    }
    
    func createFadeOutAnimation(values: [Any] = [1, 0.75, 0.5, 0.25, 0], keyTimes: [NSNumber] = [0, 0.25, 0.5, 0.75, 1], duration: TimeInterval = 0.75, timingFunction: CAMediaTimingFunction) -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "opacity")
        animation.values = values
        animation.keyTimes = keyTimes
        animation.duration = duration
        animation.timingFunction = timingFunction
        return animation
    }
    
    func createPositionAnimation(fromValue: NSValue, toValue: NSValue, duration: TimeInterval = 0.75, timingFunction: CAMediaTimingFunction) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = duration
        animation.timingFunction = timingFunction
        return animation
    }
}

// MARK: - Actions for UIView

extension Animatable where Self: UIView {
    
    func animateUp(toYValue: CGFloat, duration: TimeInterval, reverse: Bool) {
        let fromVaule = NSValue(cgPoint: self.center)
        let toValue = NSValue(cgPoint: CGPoint(x: self.center.x, y: toYValue))
        let timingFuntion = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        let moveAnimation = createPositionAnimation(fromValue: fromVaule, toValue: toValue, duration: duration, timingFunction: timingFuntion)
        moveAnimation.autoreverses = reverse
        
        let opacityAnimation = createFadeOutAnimation(timingFunction: timingFuntion)
        let animations = CAAnimationGroup()
        animations.animations = [moveAnimation, opacityAnimation]
        
        layer.add(animations, forKey: "position")
    }
}
