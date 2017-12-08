//
//  UIViewExtension.swift
//  PokedexApp
//
//  Created by Dara on 6/24/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

extension UIView: Animatable {
    
    func removeAllSubviews() {
        
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
    
    func setOriginBelow(_ view: UIView, spacing: CGFloat = 8) {
        
        self.frame.origin.y = view.frame.origin.y + view.frame.height + spacing
    }
    
    func sizeToContent(verticalSpacing: CGFloat = 0) {
        
        guard let lastSubview = self.subviews.last else { return }
        self.frame.size.height = lastSubview.frame.origin.y + lastSubview.frame.height + verticalSpacing * 2
    }
}
