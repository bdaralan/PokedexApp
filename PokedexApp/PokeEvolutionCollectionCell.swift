//
//  PokeEvolutionCollectionCell.swift
//  PokedexApp
//
//  Created by Dara Beng on 11/21/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class PokeEvolutionCollectionCell: UICollectionViewCell {
    
    let label: RIOUILabel = RIOUILabel()
    let imageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureCell()
    }
    
    private func configureCell() {
        configureLabel()
        configureImageView()
        
        // constraints
        contentView.addSubview(label)
        contentView.addSubview(imageView)
    
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 16).isActive = true
        label.widthAnchor.constraint(equalToConstant: 55).isActive = true
    
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 8).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    private func configureImageView() {
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: Variable.allPokemonsSortedByName.first!.imageName)
    }
    
    private func configureLabel() {
        label.font = UIFont(name: "\(label.font.familyName)-Bold", size: label.font.pointSize)
        label.text = "→"
        label.textAlignment = .left
        label.roundLabel.text = "16"
    }
}
