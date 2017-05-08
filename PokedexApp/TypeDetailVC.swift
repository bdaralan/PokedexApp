//
//  TypeDetailVC.swift
//  PokedexApp
//
//  Created by Dara on 4/30/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class TypeDetailVC: UIViewController {

    @IBOutlet weak var strongAgainstLbl: SectionUILabel!
    @IBOutlet weak var resistAgainstLbl: SectionUILabel!
    @IBOutlet weak var weakAgainstLbl: SectionUILabel!
    
    
    var type: String! //will be passed by segue
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(type)
    }
}
