//
//  AnimatableView.swift
//  PokedexApp
//
//  Created by Dara on 6/11/17.
//  Copyright © 2017 iDara09. All rights reserved.
//


/*
// TODO: - remove self and self.dimView from superview after dismissed
    
    # Issues:
        - animationDidStop does not get called
*/
 
import UIKit

class AnimatableView: UIView, CAAnimationDelegate {
    
    var dimView: UIView!
    
    var animationDuration: TimeInterval = 0.5
    
    var timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
    
    var autoreverses = false
    
    var fromValue: NSValue!
    
    var toValue: NSValue!
    
    var swipeToDismissDirection: UISwipeGestureRecognizerDirection {
        
        if fromValue.cgPointValue.x < toValue.cgPointValue.x { //swipe left
            return UISwipeGestureRecognizerDirection.left
            
        } else if fromValue.cgPointValue.x > toValue.cgPointValue.x { //swipe right
            return UISwipeGestureRecognizerDirection.right
            
        } else if fromValue.cgPointValue.y < toValue.cgPointValue.y { //swipe up
            return UISwipeGestureRecognizerDirection.up
            
        } else if fromValue.cgPointValue.y > toValue.cgPointValue.y { //swipt down
            return UISwipeGestureRecognizerDirection.down
            
        } else { //default: swipe up
            return UISwipeGestureRecognizerDirection.up
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.white
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.3
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.awakeFromNib()
        self.dimView = initDimView()
        
        self.layer.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        //self.removeFromSuperview()
        print("removeFromSuperview")
    }
    
    
    
    func animatePosition(fromValue: NSValue, toValue: NSValue) {
        
        self.fromValue = fromValue
        self.toValue = toValue
        
        //DispatchQueue.main.async {
            
            // setup self
            let animation = self.createPositionAnimation(fromValue: fromValue, toValue: toValue)
            
            let dismissGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.handleDismiss))
            dismissGesture.direction = self.swipeToDismissDirection
            self.addGestureRecognizer(dismissGesture)
            self.isUserInteractionEnabled = true
            
            // setup self.dimView
            let dimAnimation = self.createOpacityAnimation(values: [0, 0.25, 0.5, 1], keyTimes: [0, 0.25, 0.5, 1])
            
            // add animation
            self.layer.add(animation, forKey: "position")
            self.dimView.layer.add(dimAnimation, forKey: "opacity")
            self.dimView.alpha = 1
        //}
    }
    
    ///: Dismiss `self` and `self.dimView`
    func handleDismiss() {
        
        // animate self
        let animation = createPositionAnimation(fromValue: toValue, toValue: fromValue)
        self.layer.add(animation, forKey: "position")
        
        // keep self at toValue position
        self.center = fromValue.cgPointValue
        self.layer.shadowOpacity = 0
        
        // animate self.dimView
        let dimAnimation = createOpacityAnimation(values: [1, 0.5, 0.25, 0], keyTimes: [0, 0.25, 0.5, 1])
        self.dimView.layer.add(dimAnimation, forKey: "opacity")
        self.dimView.alpha = 0
    }
    
    ///: Initialize self.dimView. Must be called before `self` is initialize
    func initDimView() -> UIView {
        
        let dimView: UIView = {
            let x = self.frame.origin.x
            let y = Constant.Constrain.frameUnderNavController.origin.y
            let width = self.frame.width
            let height = Constant.Constrain.keyWindowFrame.height - y
            
            let view = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
            view.backgroundColor = UIColor(white: 0, alpha: 0.1)
            
            return view
        }()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDismiss))
        dimView.addGestureRecognizer(tapGesture)
        dimView.isUserInteractionEnabled = true
        
        return dimView
    }
}



// MARK: - Function for creating simple animations
extension AnimatableView {
    
    func createPositionAnimation(fromValue: NSValue, toValue: NSValue) -> CABasicAnimation {
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.timingFunction = timingFunction
        animation.duration = animationDuration
        animation.autoreverses = autoreverses
        animation.fromValue = fromValue
        animation.toValue = toValue
        
        return animation
    }
    
    func createOpacityAnimation(values: [Any], keyTimes: [NSNumber]) -> CAKeyframeAnimation {
        
        let animation = CAKeyframeAnimation(keyPath: "opacity")
        animation.duration = animationDuration
        animation.values = values
        animation.keyTimes = keyTimes
        
        let timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.timingFunctions = [timingFunction, timingFunction, timingFunction]
        
        return animation
    }
}



// MARK: - Convenience init for pokemon's weaknesses and pokedex entry
extension AnimatableView {
    
    convenience init(pokemonWeaknesses pokemon: Pokemon) {
        
        self.init(frame: Constant.Constrain.frameUnderNavController)
        
        let spacing = Constant.Constrain.spacing
        let margin = Constant.Constrain.margin
        
        var y: CGFloat = spacing
        
        let weaknesses = pokemon.weaknesses
        var weaknessLabels = [TypeUILabel]()
        
        for (type, effective) in weaknesses {
            
            let typeLabel: TypeUILabel = {
                let label = TypeUILabel()
                label.frame.origin.x = margin
                label.frame.origin.y = y
                label.text = type
                return label
            }()
            
            let effectiveLabel: TypeUILabel = {
                let label = TypeUILabel()
                label.frame.origin.x = margin + label.frame.width + spacing
                label.frame.origin.y = y
                label.text = "\(effective)x"
                label.backgroundColor = typeLabel.backgroundColor
                
                // MARK: - Pokemon's weaknesses effective width
                if effective == "1/4" {
                    label.frame.size.width = label.frame.height * 2
                } else if effective == "1/2" {
                    label.frame.size.width = label.frame.height * 4
                } else if effective == "2" {
                    label.frame.size.width = label.frame.height * 8
                } else if effective == "4" {
                    label.frame.size.width = self.frame.width - label.frame.width - spacing - (margin * 2)
                } else if effective == "0" { // "0"
                    label.frame.size.width = label.frame.height * 2
                    label.textAlignment = .left
                    label.font = UIFont(name: "\(label.font.fontName)-Bold", size: label.font.pointSize)
                    label.textColor = typeLabel.backgroundColor
                    label.backgroundColor = UIColor.clear
                }
                
                return label
            }()
            
            weaknessLabels.append(typeLabel)
            weaknessLabels.append(effectiveLabel)
            
            y += typeLabel.frame.height + spacing
            self.frame.size.height = y
        }
        
        for label in weaknessLabels { self.addSubview(label) }
    }
    
    convenience init(text: String) {
        
        self.init(frame: Constant.Constrain.frameUnderNavController)
        
        let margin = Constant.Constrain.margin
        let spacing = Constant.Constrain.spacing
        let width = self.frame.width - margin * 2
        let height = self.frame.height
        
        let textView: UITextView = {
            let textView = UITextView(frame: CGRect(x: margin, y: spacing, width: width, height: height))
            textView.font = Constant.Font.appleSDGothicNeoRegular
            textView.isScrollEnabled = false
            textView.isEditable = false
            
            return textView
        }()
        
        textView.text = text
        textView.sizeToFit()
        
        self.frame.size.height = textView.frame.height + spacing
        
        self.addSubview(textView)
    }
}



// MARK: - Delete this later
extension UIView {
    
    class func animate(views: [UIView], to toOrigin: CGPoint, withDuration duration: TimeInterval, willReturn: Bool = false, action: (), completion: ()) {
        
        let returnOriginY = views.first?.frame.origin.y
        
        self.animate(withDuration: duration, animations: {
            
            for view in views {
                view.frame.origin.y = toOrigin.y
                view.alpha = 0
            }
        }) { (Bool) in
            action
            self.animate(withDuration: duration, animations: {
                if willReturn, let toY = returnOriginY {
                    for view in views {
                        view.frame.origin.y = toY
                        view.alpha = 1
                    }
                }
            }) { (Bool) in
                completion
            }
        }
    }
    
    func removeAllSubviews() {
        
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
    }
    
    func setOriginBelow(_ view: UIView, spacing: CGFloat = 8) {
        
        self.frame.origin.y = view.frame.origin.y + view.frame.height + spacing
    }
    
    func sizeToContent(verticalSpacing: CGFloat = 0) {
        
        if let lastSubview = self.subviews.last {
            self.frame.size.height = lastSubview.frame.origin.y + lastSubview.frame.height + verticalSpacing * 2
        }
    }
}
