//
//  MoveDetailCell.swift
//  PokedexApp
//
//  Created by Dara on 5/17/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class MoveDetailCell: UITableViewCell {
    
//    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var nameLbl: RIOUILabel!
    @IBOutlet weak var typeLbl: TypeUILabel!
    @IBOutlet weak var powerLbl: RIOUILabel!
    @IBOutlet weak var probLbl: RIOUILabel!
    @IBOutlet weak var accuracyLbl: RIOUILabel!
    @IBOutlet weak var ppLbl: RIOUILabel!
    @IBOutlet weak var tmLbl: RIOUILabel!
    @IBOutlet weak var effectTextView: MoveDetailUITextView!
        
    var height: CGFloat {
        return nameLbl.frame.origin.y * 2 + effectTextView.frame.origin.y + effectTextView.frame.height
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(false, animated: false)
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
        let hSpacing: CGFloat = 16 // horizontal
        let vSpacing: CGFloat = 24 // vertical
        let typeSize = TypeUILabel.defaultSize
        
        typeLbl.translatesAutoresizingMaskIntoConstraints = false
        typeLbl.topAnchor.constraint(equalTo: topAnchor, constant: vSpacing).isActive = true
        typeLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -hSpacing).isActive = true
        typeLbl.widthAnchor.constraint(equalToConstant: typeSize.width).isActive = true
        typeLbl.heightAnchor.constraint(equalToConstant: typeSize.height).isActive = true
        
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.topAnchor.constraint(equalTo: typeLbl.topAnchor).isActive = true
        nameLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: hSpacing).isActive = true
        nameLbl.trailingAnchor.constraint(equalTo: typeLbl.leadingAnchor, constant: -hSpacing).isActive = true
        nameLbl.heightAnchor.constraint(equalToConstant: typeSize.height).isActive = true
        
        powerLbl.translatesAutoresizingMaskIntoConstraints = false
        powerLbl.topAnchor.constraint(equalTo: nameLbl.bottomAnchor, constant: vSpacing).isActive = true
        powerLbl.leadingAnchor.constraint(equalTo: nameLbl.leadingAnchor).isActive = true
        powerLbl.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5, constant: -hSpacing * 2).isActive = true
        powerLbl.heightAnchor.constraint(equalToConstant: typeSize.height).isActive = true
        
        ppLbl.translatesAutoresizingMaskIntoConstraints = false
        ppLbl.topAnchor.constraint(equalTo: powerLbl.bottomAnchor, constant: vSpacing).isActive = true
        ppLbl.leadingAnchor.constraint(equalTo: powerLbl.leadingAnchor).isActive = true
        ppLbl.widthAnchor.constraint(equalTo: powerLbl.widthAnchor).isActive = true
        ppLbl.heightAnchor.constraint(equalToConstant: typeSize.height).isActive = true
        
        accuracyLbl.translatesAutoresizingMaskIntoConstraints = false
        accuracyLbl.topAnchor.constraint(equalTo: ppLbl.bottomAnchor, constant: vSpacing).isActive = true
        accuracyLbl.leadingAnchor.constraint(equalTo: powerLbl.leadingAnchor).isActive = true
        accuracyLbl.widthAnchor.constraint(equalTo: powerLbl.widthAnchor).isActive = true
        accuracyLbl.heightAnchor.constraint(equalTo: powerLbl.heightAnchor).isActive = true
        
        probLbl.translatesAutoresizingMaskIntoConstraints = false
        probLbl.topAnchor.constraint(equalTo: typeLbl.bottomAnchor, constant: vSpacing).isActive = true
        probLbl.trailingAnchor.constraint(equalTo: typeLbl.trailingAnchor).isActive = true
        probLbl.widthAnchor.constraint(equalTo: powerLbl.widthAnchor).isActive = true
        probLbl.heightAnchor.constraint(equalTo: powerLbl.heightAnchor).isActive = true
        
        tmLbl.translatesAutoresizingMaskIntoConstraints = false
        tmLbl.topAnchor.constraint(equalTo: probLbl.bottomAnchor, constant: vSpacing).isActive = true
        tmLbl.trailingAnchor.constraint(equalTo: typeLbl.trailingAnchor).isActive = true
        tmLbl.widthAnchor.constraint(equalTo: powerLbl.widthAnchor).isActive = true
        tmLbl.heightAnchor.constraint(equalTo: powerLbl.heightAnchor).isActive = true
        
        effectTextView.translatesAutoresizingMaskIntoConstraints = false
        effectTextView.topAnchor.constraint(equalTo: accuracyLbl.bottomAnchor, constant: vSpacing).isActive = true
        effectTextView.widthAnchor.constraint(equalTo: widthAnchor, constant: -(hSpacing * 2)).isActive = true
        effectTextView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    private func configureCell() {
        configureConstraints()
    }
}
