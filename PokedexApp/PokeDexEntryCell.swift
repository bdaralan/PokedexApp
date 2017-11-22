//
//  PokeDexEntryCell.swift
//  PokedexApp
//
//  Created by Dara Beng on 11/22/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class PokeDexEntryCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(false, animated: false)
    }
    
    private func configureCell() {
        
    }
}
