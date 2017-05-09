//
//  TMDetailVC.swift
//  PokedexApp
//
//  Created by Dara on 5/9/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class TMDetailVC: UIViewController {

    var tm: Item! //will be assigned by segue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    func updateUI() {
        
        if !tm.hasCompletedInfo {
            tm.parseCompletedInfo()
        }
        
        self.title = tm.name
    }
}
