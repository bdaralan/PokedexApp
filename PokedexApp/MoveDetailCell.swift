//
//  MoveDetailCell.swift
//  PokedexApp
//
//  Created by Dara on 5/17/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

private let hSpacing: CGFloat = 16 // horizontal
private let vSpacing: CGFloat = 32 // vertical
private let labelSize = TypeUILabel.defaultSize

class MoveDetailCell: UITableViewCell {
    
    let nameLbl = RIOUILabel()
    let typeLbl = TypeUILabel()
    let powerLbl = RIOUILabel()
    let probLbl = RIOUILabel()
    let accuracyLbl = RIOUILabel()
    let ppLbl = RIOUILabel()
    let tmLbl = RIOUILabel()
    let effectTextView = MoveDetailUITextView()
        
    var height: CGFloat {
        return nameLbl.frame.origin.y * 2 + effectTextView.frame.origin.y + effectTextView.frame.height
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureContentView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(false, animated: false)
    }
    
    private func configureContentView() {
        configureConstraints()
    }
    
    func configureCell(for move: Move) {
        nameLbl.text = move.name
        nameLbl.backgroundColor = DBColor.get(color: move.type)
        nameLbl.roundLabel.layer.borderColor = nameLbl.backgroundColor?.cgColor
        
        var category = move.category
        nameLbl.roundLabel.backgroundColor = DBColor.get(color: category)
        nameLbl.roundLabel.textColor = UIColor.white
        
        switch category {
        case "Physical": category = "P"
        case "Special": category = "S"
        case "Status": category = "S"
        default:
            category = "–"
            nameLbl.roundLabel.textColor = UIColor.black
            nameLbl.roundLabel.backgroundColor = UIColor.white
        }
        
        nameLbl.roundLabel.text = category
        
        typeLbl.text = move.type
        
        powerLbl.text = "Power"
        powerLbl.roundLabel.text = move.power.isEmpty ? "–" : move.power
        
        probLbl.text = "Prob %"
        probLbl.roundLabel.text = move.prob.isEmpty ? "–" : "\(move.prob)"
        
        ppLbl.text = "PP"
        ppLbl.roundLabel.text = move.pp.isEmpty ? "–" : move.pp
        
        accuracyLbl.text = "Accuracy"
        accuracyLbl.roundLabel.text = move.accuracy.isEmpty ? "–" : move.accuracy
        
        tmLbl.text = "TM"
        tmLbl.roundLabel.text = move.tm.isEmpty ? "–" : move.tm
        
        effectTextView.text = move.effect.isEmpty ? "–" : move.effect
    }
    
    private func configureConstraints() {
        contentView.addSubview(typeLbl)
        typeLbl.translatesAutoresizingMaskIntoConstraints = false
        typeLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: vSpacing).isActive = true
        typeLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -hSpacing).isActive = true
        typeLbl.widthAnchor.constraint(equalToConstant: labelSize.width).isActive = true
        typeLbl.heightAnchor.constraint(equalToConstant: labelSize.height).isActive = true
        
        contentView.addSubview(nameLbl)
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.topAnchor.constraint(equalTo: typeLbl.topAnchor).isActive = true
        nameLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: hSpacing).isActive = true
        nameLbl.trailingAnchor.constraint(equalTo: typeLbl.leadingAnchor, constant: -hSpacing).isActive = true
        nameLbl.heightAnchor.constraint(equalToConstant: labelSize.height).isActive = true
        
        contentView.addSubview(powerLbl)
        powerLbl.translatesAutoresizingMaskIntoConstraints = false
        powerLbl.topAnchor.constraint(equalTo: nameLbl.bottomAnchor, constant: vSpacing).isActive = true
        powerLbl.leadingAnchor.constraint(equalTo: nameLbl.leadingAnchor).isActive = true
        powerLbl.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5, constant: -hSpacing * 2).isActive = true
        powerLbl.heightAnchor.constraint(equalToConstant: labelSize.height).isActive = true
        
        contentView.addSubview(ppLbl)
        ppLbl.translatesAutoresizingMaskIntoConstraints = false
        ppLbl.topAnchor.constraint(equalTo: powerLbl.bottomAnchor, constant: vSpacing).isActive = true
        ppLbl.leadingAnchor.constraint(equalTo: powerLbl.leadingAnchor).isActive = true
        ppLbl.widthAnchor.constraint(equalTo: powerLbl.widthAnchor).isActive = true
        ppLbl.heightAnchor.constraint(equalTo: powerLbl.heightAnchor).isActive = true
        
        contentView.addSubview(accuracyLbl)
        accuracyLbl.translatesAutoresizingMaskIntoConstraints = false
        accuracyLbl.topAnchor.constraint(equalTo: ppLbl.bottomAnchor, constant: vSpacing).isActive = true
        accuracyLbl.leadingAnchor.constraint(equalTo: powerLbl.leadingAnchor).isActive = true
        accuracyLbl.widthAnchor.constraint(equalTo: powerLbl.widthAnchor).isActive = true
        accuracyLbl.heightAnchor.constraint(equalTo: powerLbl.heightAnchor).isActive = true
        
        contentView.addSubview(probLbl)
        probLbl.translatesAutoresizingMaskIntoConstraints = false
        probLbl.topAnchor.constraint(equalTo: typeLbl.bottomAnchor, constant: vSpacing).isActive = true
        probLbl.trailingAnchor.constraint(equalTo: typeLbl.trailingAnchor).isActive = true
        probLbl.widthAnchor.constraint(equalTo: powerLbl.widthAnchor).isActive = true
        probLbl.heightAnchor.constraint(equalTo: powerLbl.heightAnchor).isActive = true
        
        contentView.addSubview(tmLbl)
        tmLbl.translatesAutoresizingMaskIntoConstraints = false
        tmLbl.topAnchor.constraint(equalTo: probLbl.bottomAnchor, constant: vSpacing).isActive = true
        tmLbl.trailingAnchor.constraint(equalTo: typeLbl.trailingAnchor).isActive = true
        tmLbl.widthAnchor.constraint(equalTo: powerLbl.widthAnchor).isActive = true
        tmLbl.heightAnchor.constraint(equalTo: powerLbl.heightAnchor).isActive = true
        
        contentView.addSubview(effectTextView)
        effectTextView.translatesAutoresizingMaskIntoConstraints = false
        effectTextView.topAnchor.constraint(equalTo: accuracyLbl.bottomAnchor, constant: vSpacing).isActive = true
//        effectTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -vSpacing).isActive = true
        effectTextView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -(hSpacing * 2)).isActive = true
//        effectTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 36).isActive = true
        effectTextView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
}
