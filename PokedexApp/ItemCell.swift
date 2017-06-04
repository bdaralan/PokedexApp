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
    
    weak var item: Item!
    
    func configureCell(item: Item) {
        
        self.item = item
        
        self.lhsLbl.text = self.item.name
        self.rhsLbl.text = self.item.category
    }
    
    func configureCell(tm: Item) {
        
        self.item = tm
        
        self.lhsLbl.text = self.item.name
        self.rhsLbl.isHidden = true
    }
    
    func configureCell(berry: Item) {
        
        self.item = berry
        
        self.lhsLbl.text = self.item.name
        self.rhsLbl.isHidden = true
    }
}
