//
//  AnimatableView.swift
//  PokedexApp
//
//  Created by Dara on 6/11/17.
//  Copyright © 2017 iDara09. All rights reserved.
//
 
import UIKit

class AnimatableView: UIView, CAAnimationDelegate {
    
    var dimView: UIView!
    
    var animationDuration: TimeInterval = 0.75
    
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
    
    private var willDismiss = false
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.white
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.3
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.awakeFromNib()
        self.initDimView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMoveToSuperview() {
        
        // Add `self.dimView` to the superview when `self` is added to the superview
        superview?.insertSubview(self.dimView, belowSubview: self)
        
        // Add constraints
        let views = ["dimView": self.dimView] as [String: UIView]
        
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[dimView]|", options: [], metrics: nil, views: views)
        
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[dimView]|", options: [], metrics: nil, views: views)
        
        let topConstraint = NSLayoutConstraint.init(item: self.dimView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        
        superview?.addConstraints(hConstraints + vConstraints + [topConstraint])
    }
    
    
    
    // MARK: - Superclass properties
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        
        self.dimView.removeFromSuperview()
    }
    
    
    
    // MARK: - CAAnimationDelegate
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if self.willDismiss {
            self.removeFromSuperview()
        
        } else {
            self.addDismissGestures()
        }
    }
    
    
    
    // MARK: - Functions
    
    ///: Animate `self` with swipe to dismiss gesture attached
    func animatePosition(fromValue: NSValue, toValue: NSValue) {
        
        self.fromValue = fromValue
        self.toValue = toValue
        self.willDismiss = false
        
        DispatchQueue.global(qos: .default).async {
            // create animations
            let selfAnimation = self.createPositionWithOpacityAnimation(fromValue: self.fromValue, toValue: self.toValue, opacityValues: [0, 0.25, 0.5, 1], keyTimes: [0, 0.25, 0.5, 1])
            
            // use with animationDidStop to remove `self` from superview on swipe to dismiss
            selfAnimation.delegate = self
            
            let dimAnimation = self.createOpacityAnimation(values: [0, 0.25, 0.5, 1], keyTimes: [0, 0.25, 0.5, 1])
            
            
            DispatchQueue.main.async {
                // animations begin
                self.layer.add(selfAnimation, forKey: "position")
                self.dimView.layer.add(dimAnimation, forKey: "opacity")
                
                // animations end
                self.center = self.toValue.cgPointValue
                self.dimView.alpha = 1
            }
        }
    }
    
    ///: Dismiss `self` and `self.dimView`
    func handleDismiss() {
        
        self.willDismiss = true
        
        DispatchQueue.global(qos: .default).async {
            // create animations
            let selfAnimation = self.createPositionWithOpacityAnimation(fromValue: self.toValue, toValue: self.fromValue, opacityValues: [1, 0.5, 0.25, 0], keyTimes: [0, 0.25, 0.5, 1])
            
            // use with animationDidStop to remove `self` from superview when animations end
            selfAnimation.delegate = self
            
            let dimAnimation = self.createOpacityAnimation(values: [1, 0.5, 0.25, 0], keyTimes: [0, 0.25, 0.5, 1])
            
            DispatchQueue.main.async {
                // animations begin
                self.layer.add(selfAnimation, forKey: "position")
                self.dimView.layer.add(dimAnimation, forKey: "opacity")
                
                // animations end
                self.center = self.fromValue.cgPointValue
                self.alpha = 0
                self.dimView.alpha = 0
            }
        }
    }
}



// MARK: - Helper function for creating simple animations and dimView

extension AnimatableView {
    
    func createPositionAnimation(fromValue: NSValue, toValue: NSValue) -> CABasicAnimation { 
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.timingFunction = timingFunction
        animation.duration = animationDuration
        animation.autoreverses = autoreverses
        
        return animation
    }
    
    func createOpacityAnimation(values: [Any], keyTimes: [NSNumber]) -> CAKeyframeAnimation {
        
        let animation = CAKeyframeAnimation(keyPath: "opacity")
        animation.values = values
        animation.keyTimes = keyTimes
        animation.duration = animationDuration
        animation.timingFunction = timingFunction
        
        return animation
    }
    
    func createPositionWithOpacityAnimation(fromValue: NSValue, toValue: NSValue, opacityValues: [Any], keyTimes: [NSNumber]) -> CAAnimationGroup {
        
        let positionAnimation = createPositionAnimation(fromValue: fromValue, toValue: toValue)
        let opacityAnimation = createOpacityAnimation(values: opacityValues, keyTimes: keyTimes)
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [positionAnimation, opacityAnimation]
        animationGroup.duration = animationDuration
        animationGroup.timingFunction = timingFunction
        
        return animationGroup
    }
    
    ///: Initialize self.dimView. Must be called before `self` is initialize
    func initDimView() {
    
        self.dimView = UIView()
        self.dimView.translatesAutoresizingMaskIntoConstraints = false
        self.dimView.backgroundColor = UIColor(white: 0, alpha: 0.2)
        self.dimView.alpha = 0
    }
    
    ///: Add swipe and tap to dismiss for `self` and `self.dimView`
    func addDismissGestures() {
        
        // add swipe to dismiss gesture to self
        let dismissGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.handleDismiss))
        dismissGesture.direction = self.swipeToDismissDirection
        self.addGestureRecognizer(dismissGesture)
        self.isUserInteractionEnabled = true
        
        // add tap to dismiss gesture to self.dimView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDismiss))
        dimView.addGestureRecognizer(tapGesture)
        dimView.isUserInteractionEnabled = true
    }
}



// MARK: - Convenience init for pokemon's weaknesses and pokedex entry
extension AnimatableView {
    
    convenience init(pokemonWeaknesses pokemon: Pokemon) {
        
        self.init(frame: Constant.Constrain.frameUnderNavController)
        
        let weaknesses = pokemon.weaknesses
        
        var typeLabels = [TypeUILabel]()
        var effectiveLabels = [TypeUILabel]()
        
        for (type, effective) in weaknesses {
            
            let typeLabel = TypeUILabel()
            typeLabel.text = type
            
            let effectiveLabel = TypeUILabel()
            effectiveLabel.text = "\(effective)x"
            effectiveLabel.backgroundColor = typeLabel.backgroundColor
            
            typeLabels.append(typeLabel)
            effectiveLabels.append(effectiveLabel)
        }
        
        // Add constraint to type labels and effective labels
        for i in 0 ..< typeLabels.count {
            
            let typeLabel = typeLabels[i]
            let effectiveLabel = effectiveLabels[i]
            
            self.addSubview(typeLabel)
            self.addSubview(effectiveLabel)
            
            typeLabel.translatesAutoresizingMaskIntoConstraints = false
            effectiveLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let views: [String: Any] = [
                "typeLabel": typeLabel,
                "effectiveLabel": effectiveLabel,
                "self": self,
                "padding": 16
                ]
            
            
            if i == 0 {
                let vContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[typeLabel]", options: [], metrics: nil, views: views)
                
                self.addConstraints(vContraints)
            
            } else {
                let vContraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[prevTypeLabel]-8-[typeLabel]", options: [], metrics: nil, views: ["prevTypeLabel": typeLabels[i - 1], "typeLabel": typeLabels[i]])
                
                self.addConstraints(vContraints)
            }
            
            
            // Pokemon's weaknesses effective width
            switch effectiveLabel.text! {
                
            case "1/4x":
                let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[typeLabel]-16-[effectiveLabel]", options: .alignAllCenterY, metrics: nil, views: views)
                let widthConstraint = NSLayoutConstraint.init(item: effectiveLabel, attribute: .width, relatedBy: .equal, toItem: typeLabel, attribute: .height, multiplier: 2, constant: 0)
                self.addConstraints(hConstraints + [widthConstraint])
                
            case "1/2x":
                let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[typeLabel]-16-[effectiveLabel]", options: .alignAllCenterY, metrics: nil, views: views)
                let widthConstraint = NSLayoutConstraint.init(item: effectiveLabel, attribute: .width, relatedBy: .equal, toItem: typeLabel, attribute: .height, multiplier: 4, constant: 0)
                self.addConstraints(hConstraints + [widthConstraint])
                
            case "2x":
                let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[typeLabel]-16-[effectiveLabel]", options: .alignAllCenterY, metrics: nil, views: views)
                let widthConstraint = NSLayoutConstraint.init(item: effectiveLabel, attribute: .width, relatedBy: .equal, toItem: typeLabel, attribute: .height, multiplier: 8, constant: 0)
                self.addConstraints(hConstraints + [widthConstraint])
            
            case "4x":
                let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[typeLabel]-16-[effectiveLabel]-16-|", options: .alignAllCenterY, metrics: nil, views: views)
                self.addConstraints(hConstraints)
            
            case "0x":
                let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[typeLabel]-16-[effectiveLabel]", options: .alignAllCenterY, metrics: nil, views: views)
                let widthConstraint = NSLayoutConstraint.init(item: effectiveLabel, attribute: .width, relatedBy: .equal, toItem: typeLabel, attribute: .height, multiplier: 2, constant: 0)
                self.addConstraints(hConstraints + [widthConstraint])
                
                effectiveLabel.textAlignment = .left
                effectiveLabel.font = UIFont(name: "\(effectiveLabel.font.fontName)-Bold", size: effectiveLabel.font.pointSize)
                effectiveLabel.textColor = typeLabel.backgroundColor
                effectiveLabel.backgroundColor = UIColor.clear
                
            default:()
            }
            
            let typeWidthConstraint = NSLayoutConstraint.init(item: typeLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: typeLabel.frame.width)
            
            let typeHeightConstraint = NSLayoutConstraint.init(item: typeLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: typeLabel.frame.height)
            
            let effecitveHeightConstraint = NSLayoutConstraint.init(item: effectiveLabel, attribute: .height, relatedBy: .equal, toItem: typeLabel, attribute: .height, multiplier: 1, constant: 0)
            
            self.addConstraints([typeWidthConstraint, typeHeightConstraint, effecitveHeightConstraint])
        }
        
        // calculate `self` height
        let labelCount = CGFloat(weaknesses.keys.count)
        let spacing: CGFloat = 8
        
        self.frame.size.height = (TypeUILabel().frame.height * labelCount) + (spacing * labelCount) + (spacing * 3)
    }
    
    convenience init(text: String) {
        
        self.init(frame: Constant.Constrain.frameUnderNavController)
        
        let textView: UITextView = {
            let textView = UITextView(frame: frame)
            textView.font = Constant.Font.appleSDGothicNeoRegular
            textView.isScrollEnabled = false
            textView.isEditable = false
            
            textView.text = text
            textView.sizeToFit()
            
            return textView
        }()
        
        self.addSubview(textView)
        self.frame.size.height = textView.contentSize.height + 16
    
        // add constraints
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        let views: [String: UIView] = ["textView": textView]
        
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[textView]-16-|", options: [], metrics: nil, views: views)
        
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[textView]-|", options: [], metrics: nil, views: views)
        
        self.addConstraints(hConstraints + vConstraints)
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
