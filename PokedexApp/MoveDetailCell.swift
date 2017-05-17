//
//  MoveDetailCell.swift
//  PokedexApp
//
//  Created by Dara on 5/17/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class MoveDetailCell: UITableViewCell {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var nameLbl: RIOUILabel!
    @IBOutlet weak var typeLbl: TypeUILabel!
    @IBOutlet weak var powerLbl: RIOUILabel!
    @IBOutlet weak var probLbl: RIOUILabel!
    @IBOutlet weak var accuracyLbl: RIOUILabel!
    @IBOutlet weak var ppLbl: RIOUILabel!
    @IBOutlet weak var tmLbl: RIOUILabel!
    @IBOutlet weak var effectTextView: MoveDetailUITextView!
    
    var height: CGFloat = 240

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(for move: Move) {
        
        nameLbl.text = move.name
        nameLbl.backgroundColor = UIColor.myColor.get(from: move.type)
        nameLbl.roundLabel.layer.borderColor = nameLbl.backgroundColor?.cgColor
        
        var category = move.category
        nameLbl.roundLabel.backgroundColor = UIColor.myColor.get(from: category)
        nameLbl.roundLabel.textColor = UIColor.white
        
        switch category {
        case "Physical": category = "P"
        case "Special": category = "S"
        case "Status": category = "S"
        default:
            category = "–"
            nameLbl.roundLabel.textColor = UIColor.black
            nameLbl.roundLabel.backgroundColor = UIColor.white
        }
        
        nameLbl.roundLabel.text = category
        
        typeLbl.text = move.type
        
        powerLbl.text = "Power"
        powerLbl.roundLabel.text = move.power.isEmpty ? "–" : move.power
        
        probLbl.text = "Prob %"
        probLbl.roundLabel.text = move.prob.isEmpty ? "–" : "\(move.prob)"
        
        ppLbl.text = "PP"
        ppLbl.roundLabel.text = move.pp.isEmpty ? "–" : move.pp
        
        accuracyLbl.text = "Accuracy"
        accuracyLbl.roundLabel.text = move.accuracy.isEmpty ? "–" : move.accuracy
        
        tmLbl.text = "TM"
        tmLbl.roundLabel.text = move.tm.isEmpty ? "–" : move.tm
        
        effectTextView.text = move.effect.isEmpty ? "–" : move.effect
        
        height = effectTextView.frame.origin.y + effectTextView.frame.height + CONSTANTS.constrain.spcingView
    }
}
