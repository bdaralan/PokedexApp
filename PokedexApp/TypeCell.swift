//
//  TypeCell.swift
//  PokedexApp
//
//  Created by Dara on 4/15/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class TypeCell: UITableViewCell {
    
    @IBOutlet weak var typeTextLbl: UILabel!
    @IBOutlet weak var typeLbl: TypeUILabel!
    
    private var typeLblBackgroundColor: UIColor!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        typeLbl.backgroundColor = typeLblBackgroundColor
    }

    func configureCell(type: String) {
        
        typeTextLbl.text = type
        
        typeLblBackgroundColor = COLORS.make(from: type)
        typeLbl.backgroundColor = typeLblBackgroundColor
        typeLbl.text = type
    }
}
