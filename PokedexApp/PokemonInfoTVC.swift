//
//  PokemonInfoTVC.swift
//  PokedexApp
//
//  Created by Dara Beng on 11/21/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class PokemonInfoTVC: UITableViewController {
    
    var pokemon: DBPokemon!

    var cellIds: [String]!
    
    var pokeStateCell: PokeStatCell!
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(pokemon: DBPokemon) {
        self.init(style: .plain)
        self.pokemon = pokemon
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = pokemon.info.name
        ConfigureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pokeStateCell?.updateStatSlides(animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellIds.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return PokeInfoCell.defaultCellHeight
        case 1: return PokeStatCell.defaultCellHeight
        default: return 300
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIds[indexPath.row], for: indexPath)
        switch cell {
        case is PokeInfoCell:
            let cell = cell as! PokeInfoCell
            cell.configureCell(pokemon: pokemon)
        case is PokeStatCell:
            let cell = cell as! PokeStatCell
            cell.configureCell(pokemon: pokemon)
            pokeStateCell = cell
        case is PokeEvolutionCell: ()
        case is PokeDexEntryCell:
            let cell = cell as! PokeDexEntryCell
            cell.configureCell(pokemon: pokemon)
        default: return UITableViewCell()
        }
        return cell
    }
    
    // MARK: - Function
    
    private func ConfigureTableView() {
        // register cells
        cellIds = ["\(PokeInfoCell.self)", "\(PokeStatCell.self)", "\(PokeEvolutionCell.self)", "\(PokeDexEntryCell.self)"]
        tableView.register(PokeInfoCell.self, forCellReuseIdentifier: "\(PokeInfoCell.self)")
        tableView.register(PokeStatCell.self, forCellReuseIdentifier: "\(PokeStatCell.self)")
        tableView.register(PokeEvolutionCell.self, forCellReuseIdentifier: "\(PokeEvolutionCell.self)")
        tableView.register(PokeDexEntryCell.self, forCellReuseIdentifier: "\(PokeDexEntryCell.self)")
        
        // tableview
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.showsVerticalScrollIndicator = false
    }
}
