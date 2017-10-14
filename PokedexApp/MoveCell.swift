//
//  MoveCell.swift
//  PokedexApp
//
//  Created by Dara on 4/15/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class MoveCell: UITableViewCell {
    
    @IBOutlet weak var moveNameLbl: UILabel!
    @IBOutlet weak var moveCategoryLbl: UILabel!
    @IBOutlet weak var moveTypeLbl: TypeUILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        moveCategoryLbl.layer.cornerRadius = moveCategoryLbl.frame.height / 2
        moveCategoryLbl.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        let moveCategoryBackgroundColor = moveCategoryLbl.backgroundColor
        let moveTypeBackgroundColor = moveTypeLbl.backgroundColor
        
        super.setSelected(selected, animated: animated)
        
        moveCategoryLbl.backgroundColor = moveCategoryBackgroundColor
        moveTypeLbl.backgroundColor = moveTypeBackgroundColor
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
        let moveCategoryBackgroundColor = moveCategoryLbl.backgroundColor
        let moveTypeBackgroundColor = moveTypeLbl.backgroundColor
        
        super.setHighlighted(highlighted, animated: animated)
        
        moveCategoryLbl.backgroundColor = moveCategoryBackgroundColor
        moveTypeLbl.backgroundColor = moveTypeBackgroundColor
    }
    
    func configureCell(for move: Move) {
        
        moveNameLbl.text = move.name
        
        moveCategoryLbl.backgroundColor = DBColor.get(color: move.category)
        moveCategoryLbl.textColor = UIColor.white
        
        switch move.category {
            
        case "Physical":
            moveCategoryLbl.text = "P"
            
        case "Special":
            moveCategoryLbl.text = "S"
            
        case "Status":
            moveCategoryLbl.text = "S"
            
        default:
            moveCategoryLbl.text = "-"
            moveCategoryLbl.textColor = UIColor.black
        }
        
        moveTypeLbl.text = move.type
        moveTypeLbl.backgroundColor = DBColor.get(color: move.type)
    }
}
