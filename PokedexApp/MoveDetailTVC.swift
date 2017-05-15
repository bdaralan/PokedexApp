//
//  MoveDetailTVC.swift
//  PokedexApp
//
//  Created by Dara on 4/20/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class MoveDetailTVC: UITableViewController, TypeUILabelDelegate {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var nameLbl: RIOUILabel!
    @IBOutlet weak var typeLbl: TypeUILabel!
    @IBOutlet weak var powerLbl: RIOUILabel!
    @IBOutlet weak var probLbl: RIOUILabel!
    @IBOutlet weak var accuracyLbl: RIOUILabel!
    @IBOutlet weak var ppLbl: RIOUILabel!
    @IBOutlet weak var tmLbl: RIOUILabel!
    @IBOutlet weak var effectTextView: MoveDetailUITextView!
    
    var move: Move! //will be assigned during segue
    var moves: [Move]!
    
    var segmentControl: RoundUISegmentedControl!
    var sectionHeaderView: UIView!
    
    let moveDetailCellSection = 0
    let moveCellSection = 1
    
    let pokemonSegIndex = 0
    let nilSegInex = 1

    var moveDetailCellHeight: CGFloat = 240
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        typeLbl.delegate = self
        typeLbl.isUserInteractionEnabled = true
        
        moves = CONSTANTS.allMoves.filter(forType: move.type)
        
        configureHeaderView()
        updateUI()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return moves.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MoveCell") as? MoveCell {
            cell.configureCell(for: moves[indexPath.row])
            return cell
        }
        
        return MoveCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return sectionHeaderViewHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return sectionHeaderView
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let typeDetailTVC = segue.destination as? TypeDetailTVC, let type = sender as? String {
            typeDetailTVC.type = type
        }
    }
}


// MARK: Computed Property
extension MoveDetailTVC {
    
    var sectionHeaderViewWidth: CGFloat {
        return tableView.frame.width
    }
    
    var sectionHeaderViewHeight: CGFloat {
        return segmentControl.frame.height + 16
    }
    
    var headerViewHeight: CGFloat {
        return effectTextView.frame.origin.y + effectTextView.frame.height + CONSTANTS.constrain.spcingView
    }
}


// MARK: Protocol
extension MoveDetailTVC {
    
    func typeUILabel(didTap tapGesture: UITapGestureRecognizer) {
        
        performSegue(withIdentifier: "TypeDetailTVC", sender: move.type)
    }
}


// MARK: - Updater
extension MoveDetailTVC {
    
    func updateUI() {
        
        if !move.hasCompletedInfo {
            move.parseCompletedInfo()
        }
        
        nameLbl.text = move.name
        nameLbl.backgroundColor = UIColor.myColor.get(from: move.type)
        nameLbl.roundLabel.layer.borderColor = nameLbl.backgroundColor?.cgColor
        
        var category = move.category
        nameLbl.roundLabel.backgroundColor = UIColor.myColor.get(from: category)
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
        
        probLbl.text = "Proc"
        probLbl.roundLabel.text = move.prob.isEmpty ? "–" : "\(move.prob)%"
        
        ppLbl.text = "PP"
        ppLbl.roundLabel.text = move.pp.isEmpty ? "–" : move.pp
        
        accuracyLbl.text = "Accuracy"
        accuracyLbl.roundLabel.text = move.accuracy.isEmpty ? "–" : move.accuracy
        
        tmLbl.text = "TM"
        tmLbl.roundLabel.text = move.tm.isEmpty ? "–" : move.tm
        
        effectTextView.text = move.effect.isEmpty ? "–" : move.effect
        effectTextView.applyStyle()
        
        headerView.frame.size.height = headerViewHeight
    }
}


// MARK: - Initializer and Handler
extension MoveDetailTVC {
    
    func configureHeaderView() {
        
        let spacing: CGFloat = 8
        
        segmentControl = {
            let sc = RoundUISegmentedControl(items: ["WillBePokemon", "MaybeMove"])
            sc.frame.origin = CGPoint(x: spacing, y: spacing)
            sc.frame.size.width = sectionHeaderViewWidth - spacing * 2
            sc.tintColor = UIColor.myColor.get(from: move.type)
            sc.layer.borderColor = sc.tintColor.cgColor
            sc.backgroundColor = UIColor.white
            
            sc.selectedSegmentIndex = pokemonSegIndex
            
            sc.addTarget(self, action: #selector(segmentControlValueChanged(_:)), for: .valueChanged)
            return sc
        }()
    
        sectionHeaderView = {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: sectionHeaderViewWidth, height: sectionHeaderViewHeight))
            view.backgroundColor = UIColor.myColor.sectionBackground
            return view
        }()
        
        sectionHeaderView.addSubview(segmentControl)
    }
    
    func segmentControlValueChanged(_ sender: RoundUISegmentedControl) {
        
        tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
        print("segmentControlValueChanged")
    }
}
