//
//  MoveVC.swift
//  PokedexApp
//
//  Created by Dara on 4/20/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class MoveVC: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var categoryLbl: CircleUILabel!
    @IBOutlet weak var typeLbl: TypeUILabel!
    @IBOutlet weak var powerLbl: UILabel!
    @IBOutlet weak var probLbl: UILabel!
    @IBOutlet weak var accuracyLbl: UILabel!
    @IBOutlet weak var ppLbl: UILabel!
    @IBOutlet weak var tmLbl: UILabel!
    //@IBOutlet weak var effectLbl: UILabel!
    @IBOutlet weak var effctTextView: UITextView!
    
    var move: Move! //will be assigned during segue
    var cell: UITableViewCell! //will be assigned during segue

    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    func updateUI() {
        
        self.navigationItem.title = move.name
        
        nameLbl.text = move.name
        categoryLbl.text = move.category
        categoryLbl.applyMoveCategoryStyle()
        typeLbl.text = move.type
        typeLbl.backgroundColor = COLORS.make(from: move.type)
        powerLbl.text = move.power
        probLbl.text = move.prob
        accuracyLbl.text = move.accuracy
        ppLbl.text = move.pp
        tmLbl.text = move.tm
        effctTextView.text = move.effect
    }
}
