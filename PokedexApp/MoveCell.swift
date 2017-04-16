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
    
    private var moveCategoryBackgroundColor: UIColor!
    private var moveTypeBackgroundColor: UIColor!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        moveCategory.layer.cornerRadius = moveCategory.frame.height / 2
        moveCategory.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        moveCategory.backgroundColor = moveCategoryBackgroundColor
        moveType.backgroundColor = moveTypeBackgroundColor
    }
    
    func configureCell(for move: Move) {
        
        moveName.text = move.name
        
        moveCategoryBackgroundColor = COLORS.make(from: move.category)
        moveCategory.backgroundColor = moveCategoryBackgroundColor
        moveCategory.textColor = UIColor.white
        
        switch move.category {
        case "Physical": moveCategory.text = "P"
        case "Special": moveCategory.text = "S"
        case "Status": moveCategory.text = "S"
        default:
            moveCategory.text = "–"
            moveCategory.textColor = UIColor.black
        }
        
        moveTypeBackgroundColor = COLORS.make(from: move.type)
        moveType.backgroundColor = moveTypeBackgroundColor
        moveType.text = move.type
    }
}
