//
//  MoveDetailVC.swift
//  PokedexApp
//
//  Created by Dara on 4/20/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class MoveDetailVC: UIViewController {
    
    @IBOutlet weak var nameLbl: RIOUILabel!
    @IBOutlet weak var typeLbl: TypeUILabel!
    @IBOutlet weak var powerLbl: RIOUILabel!
    @IBOutlet weak var probLbl: RIOUILabel!
    @IBOutlet weak var accuracyLbl: RIOUILabel!
    @IBOutlet weak var ppLbl: RIOUILabel!
    @IBOutlet weak var tmLbl: RIOUILabel!
    @IBOutlet weak var effectTextView: MoveDetailUITextView!
    
    var move: Move! //will be assigned during segue

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    func updateUI() {
        
        self.title = move.name
        
        move.parseCompletedInfo()
                
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
        typeLbl.backgroundColor = nameLbl.backgroundColor
        
        powerLbl.text = "Power"
        powerLbl.roundLabel.text = move.power.isEmpty ? "–" : move.power
        
        probLbl.text = "Proc"
        probLbl.roundLabel.text = move.prob.isEmpty ? "–" : "\(move.prob)%"
        
        ppLbl.text = "PP"
        ppLbl.roundLabel.text = move.pp.isEmpty ? "–" : move.pp
        
        accuracyLbl.text = "Accuracy"
        accuracyLbl.roundLabel.text = move.accuracy.isEmpty ? "–" : move.accuracy
        
        tmLbl.text = "TM"
        tmLbl.roundLabel.text = move.tm.isEmpty ? "–" : move.tm
        
        effectTextView.text = move.effect.isEmpty ? "–" : move.effect
        effectTextView.applyStyle()
    }
}
