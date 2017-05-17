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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(false, animated: animated)
    }

    func configureCell(for ability: Ability) {
        
        self.descriptionTextView.text = ability.description
        self.height = descriptionTextView.frame.origin.y +  descriptionTextView.frame.height + CONSTANTS.constrain.spcingView
    }
}
