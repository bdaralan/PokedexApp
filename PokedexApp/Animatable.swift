//
//  Animatable.swift
//  PokedexApp
//
//  Created by Dara on 6/10/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

protocol Animatable {}


extension Animatable where Self: UIView {
    
    func animatePosition(fromValue: NSValue, toValue: NSValue, duration: TimeInterval, autoreverses: Bool, remainAtToValue: Bool) {
        
        DispatchQueue.global(qos: .default).sync {
            let animation: CABasicAnimation = {
                let animation = CABasicAnimation(keyPath: "position")
                animation.duration = duration
                animation.autoreverses = autoreverses
                animation.fromValue = fromValue
                animation.toValue = toValue
                
                return animation
            }()
            
            DispatchQueue.main.async {
                self.layer.add(animation, forKey: "position")
                if remainAtToValue { self.center = toValue.cgPointValue }
            }
        }
    }
}


