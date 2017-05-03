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
        
        rhsLbl.text = item.name
        lhsLbl.text = item.category
    }
    
    func configureCell(tm: Item) {
        rhsLbl.text = tm.name
        lhsLbl.isHidden = true
    }
    
    func configureCell(berry: Item) {
        rhsLbl.text = berry.name
        lhsLbl.isHidden = true
    }
}
