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
    private var navigationBar: UINavigationBar!
    private var presentingCoordinate: CGRect!
    
    private var blackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.2)
        view.alpha = 0
        return view
    }()
    
    private var weaknessesView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private var pokedexEnteryView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    
    init(parentView: UIViewController) {
        self.parentView = parentView
        self.navigationBar = parentView.navigationController?.navigationBar
        
        if let window = UIApplication.shared.keyWindow {
            let height = UIApplication.shared.statusBarFrame.height + navigationBar.frame.height
            self.presentingCoordinate = CGRect(x: window.frame.origin.x, y: window.frame.origin.y, width: window.frame.width, height: height)
        }
    }
    
    
    func presentWeakness(of pokemon: Pokemon) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 1
            self.weaknessesView.frame.origin.y = self.presentingCoordinate.size.height
        }, completion: nil)
    }
    
    func presentPokedexEntery(of pokemon: Pokemon) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 1
            self.pokedexEnteryView.frame.origin.y = self.presentingCoordinate.size.height
        }, completion: nil)
    }
    
    func dismissViews() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.blackView.alpha = 0
            
            if self.weaknessesView.frame.origin.y == self.presentingCoordinate.size.height {
                self.weaknessesView.frame.origin.y = self.presentingCoordinate.origin.y - self.weaknessesView.frame.height
            } else {
                self.pokedexEnteryView.frame.origin.y = self.presentingCoordinate.origin.y - self.pokedexEnteryView.frame.height
            }
        }, completion: nil)
    }
    
    func configureViews() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissViews))
        blackView.addGestureRecognizer(tapGesture)
        blackView.frame = parentView.view.frame
        
        let height: CGFloat = 200 //currently used for weaknessesView's and pokedexEnteryView's height
        let y = self.presentingCoordinate.origin.y - height
        weaknessesView.frame = CGRect(x: 0, y: y, width: presentingCoordinate.size.width, height: height)
        pokedexEnteryView.frame = CGRect(x: 0, y: y, width: presentingCoordinate.size.width, height: height)
        
        parentView.view.addSubview(blackView)
        parentView.view.addSubview(weaknessesView)
        parentView.view.addSubview(pokedexEnteryView)
    }
}
