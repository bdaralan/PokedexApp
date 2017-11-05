//
//  AbilityDetailCell.swift
//  PokedexApp
//
//  Created by Dara on 5/16/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class AbilityDetailCell: UITableViewCell {

    @IBOutlet weak var descriptionTextView: MoveDetailUITextView!
    
    var height: CGFloat = 45
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(false, animated: false)
    }

    func configureCell(for ability: Ability) {
        descriptionTextView.text = ability.description
        height = descriptionTextView.frame.origin.y +  descriptionTextView.frame.height + Constant.Constrain.spcingView
    }
}
