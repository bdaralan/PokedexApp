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
    
    var height: CGFloat = 240 //height that will be used for ...(heightForRowAt: indexPath)
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(false, animated: animated)
    }
    
    func configureCell(forType type: String, strongAgainstTypeLbls: [TypeUILabel], weakToTypeLbls: [TypeUILabel], resistToTypeLbls: [TypeUILabel], immuneToTypeLbls: [TypeUILabel]) {
        
        self.type = type
        
        add(typeLbls: strongAgainstTypeLbls, to: strongAgainstView)
        strongAgainstView.sizeToContent()
        
        add(typeLbls: weakToTypeLbls, to: weakToView)
        weakToView.sizeToContent()
        
        add(typeLbls: resistToTypeLbls, to: resistToView)
        resistToView.sizeToContent()
        
        add(typeLbls: immuneToTypeLbls, to: immuneToView)
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
    
    private func add(typeLbls: [TypeUILabel], to view: UIView) {
        
        view.removeAllSubviews()
        
        for typeLbl in typeLbls {
            view.addSubview(typeLbl)
        }
    }
}
