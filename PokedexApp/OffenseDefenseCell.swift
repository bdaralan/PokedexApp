//
//  OffenseDefenseCell.swift
//  PokedexApp
//
//  Created by Dara on 5/13/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class OffenseDefenseCell: UITableViewCell {
    
    @IBOutlet weak var strongAgainstSecLbl: SectionUILabel!
    @IBOutlet weak var weakToSecLbl: SectionUILabel!
    @IBOutlet weak var resistToSecLbl: SectionUILabel!
    @IBOutlet weak var immuneToSecLbl: SectionUILabel!
    
    @IBOutlet weak var strongAgainstView: UIView!
    @IBOutlet weak var weakToView: UIView!
    @IBOutlet weak var resistToView: UIView!
    @IBOutlet weak var immuneToView: UIView!
    
    private var type: String!
    
    var delegateForTypeLabel: TypeUILabelDelegate?
    
    var height: CGFloat = 240 //height that will be used for ...(heightForRowAt: indexPath)
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(false, animated: animated)
    }
    
    func configureCell(forType type: String, strongAgainstTypes: [String], weakToTypes: [String], resistToTypes: [String], immuneToTypes: [String], delegate: TypeUILabelDelegate) {
        
        self.type = type
        
        add(types: strongAgainstTypes, to: strongAgainstView)
        strongAgainstView.sizeToContent()
        
        add(types: weakToTypes, to: weakToView)
        weakToView.sizeToContent()
        
        add(types: resistToTypes, to: resistToView)
        resistToView.sizeToContent()
        
        add(types: immuneToTypes, to: immuneToView)
        immuneToView.sizeToContent()
        
        let viewSpacing: CGFloat = 29
        strongAgainstView.setOriginBelow(strongAgainstSecLbl)
        weakToSecLbl.setOriginBelow(strongAgainstView, spacing: viewSpacing)
        weakToView.setOriginBelow(weakToSecLbl)
        resistToSecLbl.setOriginBelow(weakToView, spacing: viewSpacing)
        resistToView.setOriginBelow(resistToSecLbl)
        immuneToSecLbl.setOriginBelow(resistToView, spacing: viewSpacing)
        immuneToView.setOriginBelow(immuneToSecLbl)
        
        self.height = immuneToView.frame.origin.y + immuneToView.frame.height + viewSpacing
    }
    
    private func add(types: [String], to view: UIView) {
        
        view.removeAllSubviews()
        
        let spacing: CGFloat = 8
        var x: CGFloat = 8
        var y: CGFloat = 0
        
        if types.count > 0 {
            for type in types {
                if let cachedTypeLabel = globalCache.object(forKey: "PokemonType\(type)" as AnyObject) as? TypeUILabel {
                    print(cachedTypeLabel)
                    
                } else {
                    let typeLabel: TypeUILabel = {
                        let label = TypeUILabel()
                        label.frame.origin = CGPoint(x: x, y: y)
                        label.text = type
                        return label
                    }()
                    
                    x = x + typeLabel.frame.width + spacing
                    
                    if x + typeLabel.frame.width + spacing > view.frame.width - spacing {
                        x = 8
                        y = y + typeLabel.frame.height + spacing
                    }
                    
                    typeLabel.delegate = self.delegateForTypeLabel
                    typeLabel.isUserInteractionEnabled = true
                    view.addSubview(typeLabel)
                }
            }
            
        } else {
            let noneLbl: TypeUILabel = {
                let label = TypeUILabel()
                label.text = "None"
                label.textColor = UIColor.myColor.sectionText
                label.backgroundColor = UIColor.myColor.ability
                label.frame.origin.x = x
                label.frame.origin.y = y
                
                return label
            }()
            
            view.addSubview(noneLbl)
        }
    }
}
