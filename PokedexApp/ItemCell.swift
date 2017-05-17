//
//  ItemCell.swift
//  PokedexApp
//
//  Created by Dara on 5/1/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var rhsLbl: UILabel!
    @IBOutlet weak var lhsLbl: UILabel!
    
    func configureCell(item: Item) {
        
        self.lhsLbl.text = item.name
        self.rhsLbl.text = item.category
    }
    
    func configureCell(tm: Item) {
        
        self.lhsLbl.text = tm.name
        self.rhsLbl.isHidden = true
    }
    
    func configureCell(berry: Item) {
        
        self.lhsLbl.text = berry.name
        self.rhsLbl.isHidden = true
    }
}
