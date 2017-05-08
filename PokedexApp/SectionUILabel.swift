//
//  SectionUILabel.swift
//  PokedexApp
//
//  Created by Dara on 4/6/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class SectionUILabel: UILabel {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        self.backgroundColor = UIColor.myColor.sectionBackground
        self.textColor = UIColor.myColor.sectionText
        self.font = UIFont(name: "GillSans-SemiBold", size: 17)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        awakeFromNib()
        print("initfromeframe")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
