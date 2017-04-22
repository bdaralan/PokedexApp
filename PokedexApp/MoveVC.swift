//
//  MoveVC.swift
//  PokedexApp
//
//  Created by Dara on 4/20/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class MoveVC: UIViewController {
    
    @IBOutlet weak var nameLbl: InsetUILabel!
    @IBOutlet weak var typeLbl: TypeUILabel!
    @IBOutlet weak var powerLbl: InsetUILabel!
    @IBOutlet weak var probLbl: InsetUILabel!
    @IBOutlet weak var accuracyLbl: InsetUILabel!
    @IBOutlet weak var ppLbl: InsetUILabel!
    @IBOutlet weak var tmLbl: InsetUILabel!
    @IBOutlet weak var effectTextView: UITextView!
    
    var move: Move! //will be assigned during segue

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            self.updateUI()
        }
        //updateUI()
    }
    
    func updateUI() {
        
        move.parseCompletedInfo()
                
        nameLbl.text = move.name
        nameLbl.backgroundColor = COLORS.make(from: move.type)
        if let category = move.category.characters.first {
            let category = "\(category)"
            nameLbl.innerLable.text = category.isEmpty ? "–" : category
            nameLbl.innerLable.textColor = UIColor.white
            nameLbl.innerLable.backgroundColor = COLORS.make(from: move.category)
        }
        
        typeLbl.text = move.type
        typeLbl.backgroundColor = nameLbl.backgroundColor
        
        powerLbl.text = "Power"
        powerLbl.innerLable.text = move.power.isEmpty ? "–" : move.power
        
        probLbl.text = "Proc"
        probLbl.innerLable.text = move.prob.isEmpty ? "–" : "\(move.prob)%"
        
        ppLbl.text = "PP"
        ppLbl.innerLable.text = move.pp.isEmpty ? "–" : move.pp
        
        accuracyLbl.text = "Accuracy"
        accuracyLbl.innerLable.text = move.accuracy.isEmpty ? "–" : move.accuracy
        
        tmLbl.text = "TM"
        tmLbl.innerLable.text = move.tm.isEmpty ? "–" : move.tm
        
        effectTextView.text = move.effect.isEmpty ? "–" : move.effect
        effectTextView.frame.size.height = effectTextView.contentSize.height
        effectTextView.layer.cornerRadius = effectTextView.frame.height / 2
        effectTextView.layer.borderWidth = 1.0
        effectTextView.layer.borderColor = UIColor.black.cgColor
        effectTextView.clipsToBounds = true
        effectTextView.textAlignment = .center
    }
}
