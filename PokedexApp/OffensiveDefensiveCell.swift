//
//  OffensiveDefensiveCell.swift
//  PokedexApp
//
//  Created by Dara on 5/13/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class OffensiveDefensiveCell: UITableViewCell {

    @IBOutlet weak var strongAgainstSecLbl: SectionUILabel!
    @IBOutlet weak var weakToSecLbl: SectionUILabel!
    @IBOutlet weak var resistToSecLbl: SectionUILabel!
    @IBOutlet weak var immuneToSecLbl: SectionUILabel!
    
    @IBOutlet weak var strongAgainstView: UIView!
    @IBOutlet weak var weakToView: UIView!
    @IBOutlet weak var resistToView: UIView!
    @IBOutlet weak var immuneToView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(forType type: String) {
        
    }

}
