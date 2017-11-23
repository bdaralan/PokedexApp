//
//  PokeEvolutionCell.swift
//  PokedexApp
//
//  Created by Dara Beng on 11/21/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

/// Use with PokemonInfoTVC to display Pokemon's evolutions.
class PokeEvolutionCell: UITableViewCell {
    
    public static var defualtCellHeight: CGFloat { return 250 } // TODO: needs formula
    
    var evolutionCV: PokeEvolutionCV!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(false, animated: false)
    }
    
    private func configureCell() {
        evolutionCV = PokeEvolutionCV(frame: CGRect.init(origin: .zero, size: CGSize.init(width: 320, height: 300)), collectionViewLayout: PokeEvolutionCV.defaultLayout)
        evolutionCV.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(evolutionCV)
        evolutionCV.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        evolutionCV.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        evolutionCV.topAnchor.constraint(equalTo: topAnchor).isActive = true
        evolutionCV.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
