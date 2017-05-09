//
//  AbilityDetailVC.swift
//  PokedexApp
//
//  Created by Dara on 5/9/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class AbilityDetailVC: UIViewController {

    var ability: Ability! //will be assigned by segue
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    func updateUI() {
        
        if !ability.hasCompletedInfo {
            ability.parseCompletedInfo()
        }
        
        self.title = ability.name
    }
}
