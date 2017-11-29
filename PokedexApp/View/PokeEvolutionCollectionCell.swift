//
//  PokeEvolutionCollectionCell.swift
//  PokedexApp
//
//  Created by Dara Beng on 11/21/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

/// `PokeEvolutionCV`'s cell, use to display Pokemon's evolutions.
class PokeEvolutionCollectionCell: UICollectionViewCell {
    
    public static var defaultId: String { return "\(PokeEvolutionCollectionCell.self)" }
    
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
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    private func configureImageView() {
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "282")
    }
    
    private func configureLabel() {
        label.font = UIFont(name: "\(label.font.familyName)-Bold", size: label.font.pointSize)
        label.text = "→"
        label.textAlignment = .left
        label.roundLabel.text = "16"
        label.textInset = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 0)
    }
}
