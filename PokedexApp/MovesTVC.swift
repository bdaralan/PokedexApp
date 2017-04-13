//
//  MovesTVC.swift
//  PokedexApp
//
//  Created by Dara on 4/13/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class MovesTVC: UITableViewController {

    var moveJSON: [DictionarySS]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moveJSON = loadData.movesJSON()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return moveJSON.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoveCell", for: indexPath)
        let move = moveJSON[indexPath.row]
        
        if let name = move["name"],
            let type = move["type"],
            let category = move["category"],
            let power = move["power"],
            let accuracy = move["accuracy"],
            let pp = move["pp"],
            let tm = move["tm"],
            let effect = move["effect"],
            let prob = move["prob"] {
            
            cell.textLabel?.text = name
            cell.detailTextLabel?.text = category
            
            // TODO: - Display these to tableViewCell
            print("name: \(name)")
            print("Type: \(type)")
            print("Category: \(category)")
            print("Power: \(power)")
            print("Accuracy: \(accuracy)")
            print("PP: \(pp)")
            print("TM: \(tm)")
            print("Effect: \(effect)")
            print("Prob: \(prob)\n\n")
        }
        
        return cell
    }
}
