//
//  TypeCell.swift
//  PokedexApp
//
//  Created by Dara on 4/15/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class TypeCell: UITableViewCell {
    
    @IBOutlet weak var typeTextLbl: UILabel!
    @IBOutlet weak var typeLbl: TypeUILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        let typeLblBackgroundColor = typeLbl.backgroundColor
        
        super.setSelected(selected, animated: animated)

        typeLbl.backgroundColor = typeLblBackgroundColor
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
        let typeLblBackgroundColor = typeLbl.backgroundColor
        
        super.setHighlighted(highlighted, animated: animated)
        
        typeLbl.backgroundColor = typeLblBackgroundColor
    }

    func configureCell(type: String) {
        
        typeTextLbl.text = type
        
        typeLbl.backgroundColor = UIColor.myColor.get(from: type)
        typeLbl.text = type
    }
}
