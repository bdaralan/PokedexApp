//
//  MovesTVC.swift
//  PokedexApp
//
//  Created by Dara on 4/13/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class MovesTVC: UITableViewController {
    
    var moveJSON: DictionarySA!
    var moves: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareMoveJSON()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return moveJSON.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "MoveCell")
        
        if let move = moveJSON[moves[indexPath.row]] as? DictionarySS { // TODO: - Use NSCache
            if let type = move["type"],
                let category = move["category"],
                let power = move["power"],
                let accuracy = move["accuracy"],
                let pp = move["pp"],
                let tm = move["tm"],
                let effect = move["effect"],
                let prob = move["prob"] {
                
                cell.textLabel?.text = moves[indexPath.row]
                cell.detailTextLabel?.textColor = UIColor.lightGray
                cell.detailTextLabel?.text = "\(category) | \(type) | \(power) | \(accuracy) | \(pp) | \(tm) | \(effect) | \(prob)"
            }
        }
        
        return cell
    }
    
    func prepareMoveJSON() {
        
        moveJSON = loadData.movesJSON()
        let names = moveJSON.keys.sorted()
        self.moves = [String]()
        for name in names {
            moves.append(name)
        }
    }
}
