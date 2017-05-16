//
//  MoveCell.swift
//  PokedexApp
//
//  Created by Dara on 4/15/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class MoveCell: UITableViewCell {
    
    @IBOutlet weak var moveName: UILabel!
    @IBOutlet weak var moveCategory: UILabel!
    @IBOutlet weak var moveType: TypeUILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        moveCategory.layer.cornerRadius = moveCategory.frame.height / 2
        moveCategory.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        let moveCategoryBackgroundColor = moveCategory.backgroundColor
        let moveTypeBackgroundColor = moveType.backgroundColor
        
        super.setSelected(selected, animated: animated)
        
        moveCategory.backgroundColor = moveCategoryBackgroundColor
        moveType.backgroundColor = moveTypeBackgroundColor
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
        let moveCategoryBackgroundColor = moveCategory.backgroundColor
        let moveTypeBackgroundColor = moveType.backgroundColor
        
        super.setHighlighted(highlighted, animated: animated)
        
        moveCategory.backgroundColor = moveCategoryBackgroundColor
        moveType.backgroundColor = moveTypeBackgroundColor
    }
    
    func configureCell(for move: Move) {
        
        self.moveName.text = move.name
        
        self.moveCategory.backgroundColor = UIColor.myColor.get(from: move.category)
        self.moveCategory.textColor = UIColor.white
        
        switch move.category {
            
        case "Physical":
            self.moveCategory.text = "P"
            
        case "Special":
            self.moveCategory.text = "S"
            
        case "Status":
            self.moveCategory.text = "S"
            
        default:
            self.moveCategory.text = "-"
            self.moveCategory.textColor = UIColor.black
        }
        
        self.moveType.text = move.type
        self.moveType.backgroundColor = UIColor.myColor.get(from: move.type)
    }
}
