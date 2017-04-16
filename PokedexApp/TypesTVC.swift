//
//  TypesTVC.swift
//  PokedexApp
//
//  Created by Dara on 4/14/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class TypesTVC: UITableViewController {

    var types: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        types = loadData.pokemonTypes()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {

        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)


        return cell
    }
}
