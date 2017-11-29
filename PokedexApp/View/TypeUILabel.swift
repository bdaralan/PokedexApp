//
//  TypeUILabel.swift
//  PokedexApp
//
//  Created by Dara on 4/6/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

protocol TypeUILabelDelegate: class {
    
    func typeUILabel(didTap tapGesture: UITapGestureRecognizer)
}


class TypeUILabel: UILabel {
    
    weak var delegate: TypeUILabelDelegate?
        
    private var tapGesture: UITapGestureRecognizer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    convenience init() {
        self.init(frame: CGRect(origin: .zero, size: TypeUILabel.defaultSize))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
    
    private func configureView() {
        clipsToBounds = true
        textColor = UIColor.white
        textAlignment = .center
        baselineAdjustment = .alignCenters
        font = Constant.Font.gillSans
    }
    
    override var text: String? {
        didSet {
            guard let text = text else { return }
            self.backgroundColor = DBColor.get(color: text)
        }
    }
    
    override var isUserInteractionEnabled: Bool {
        didSet {
            guard isUserInteractionEnabled else {
                if tapGesture != nil { removeGestureRecognizer(tapGesture) }
                return
            }
            if tapGesture == nil {
                tapGesture = UITapGestureRecognizer(target: self, action: #selector(typeUILabelTapped))
            }
            self.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc func typeUILabelTapped() {
        delegate?.typeUILabel(didTap: tapGesture)
    }
}



extension TypeUILabel {
    
    static var defaultSize: CGSize { return CGSize(width: 80, height: 21) }
}
