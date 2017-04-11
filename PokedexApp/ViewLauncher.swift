//
//  ViewLauncher.swift
//  PokedexApp
//
//  Created by Dara on 4/10/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class ViewLauncher: NSObject {
    
    override init() {
        super.init()
    }
    
    let blackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.2)
        view.alpha = 0
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissViews))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let weaknessesView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissViews))
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    func presentWeakness(of pokemon: Pokemon, in parentView: UIView) {
        
        blackView.frame = parentView.frame
        
        let height: CGFloat = 200
        let y = parentView.frame.origin.y - height
        weaknessesView.frame = CGRect(x: 0, y: y, width: parentView.frame.width, height: height)
        
        parentView.addSubview(blackView)
        parentView.addSubview(weaknessesView)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 1
            self.weaknessesView.frame.origin.y = parentView.frame.origin.y
        }, completion: nil)
    }
    
    func dismissViews() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.blackView.alpha = 0
            self.weaknessesView.frame.origin.y = self.weaknessesView.frame.origin.y - self.weaknessesView.frame.height
        }, completion: nil)
    }
}
