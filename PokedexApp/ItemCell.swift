//
//  ItemCell.swift
//  PokedexApp
//
//  Created by Dara on 5/1/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    func configureCell(item: Item) {
        self.textLabel?.text = item.name
        self.detailTextLabel?.text = item.category
    }
    
    func configureCell(tm: Item) {
        self.textLabel?.text = tm.name
    }
    
    func configureCell(berry: Item) {
        self.textLabel?.text = berry.name
    }
}
