//
//  MoveDetailCell.swift
//  PokedexApp
//
//  Created by Dara on 5/14/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class MoveDetailCell: UITableViewCell {

    @IBOutlet weak var nameLbl: RIOUILabel!
    @IBOutlet weak var typeLbl: TypeUILabel!
    @IBOutlet weak var powerLbl: RIOUILabel!
    @IBOutlet weak var probLbl: RIOUILabel!
    @IBOutlet weak var accuracyLbl: RIOUILabel!
    @IBOutlet weak var ppLbl: RIOUILabel!
    @IBOutlet weak var tmLbl: RIOUILabel!
    @IBOutlet weak var effectTextView: MoveDetailUITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        typeLbl.delegate = self
//        typeLbl.isUserInteractionEnabled = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
