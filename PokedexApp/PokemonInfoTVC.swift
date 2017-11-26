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
        let cellId = cellIds[indexPath.row]
        switch cellId {
        case PokeInfoCell.defaultId: return PokeInfoCell.defaultCellHeight
        case PokeStatCell.defaultId: return PokeStatCell.defaultCellHeight
        case PokeEvolutionCell.defaultId: return PokeEvolutionCell.defualtCellHeight
        case PokeDexEntryCell.defaultId: return PokeDexEntryCell.defaultCellHeight
        default: return 0
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
        default: ()
        }
        return cell
    }
    
    // MARK: - Function
    
    private func ConfigureTableView() {
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = UIEdgeInsets.zero
        
        // register cells
        cellIds = []
        tableView.register(PokeInfoCell.self, forCellReuseIdentifier: PokeInfoCell.defaultId)
        cellIds.append(PokeInfoCell.defaultId)
        tableView.register(PokeStatCell.self, forCellReuseIdentifier: PokeStatCell.defaultId)
        cellIds.append(PokeStatCell.defaultId)
        tableView.register(PokeEvolutionCell.self, forCellReuseIdentifier: PokeEvolutionCell.defaultId)
        cellIds.append(PokeEvolutionCell.defaultId)
        tableView.register(PokeDexEntryCell.self, forCellReuseIdentifier: PokeDexEntryCell.defaultId)
        cellIds.append(PokeDexEntryCell.defaultId)
    }
}
