//
//  TypeDetailVC.swift
//  PokedexApp
//
//  Created by Dara on 4/30/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class TypeDetailVC: UIViewController {
    
    @IBOutlet weak var weakAgainstSectionLbl: SectionUILabel!
    @IBOutlet weak var resistAgainstSectionLbl: SectionUILabel!
    @IBOutlet weak var immuneAgainstSectionLbl: SectionUILabel!
    
    
    var type: String! //will be assigned by segue
    var weakAgainst = [String]()
    var resistAgainst = [String]()
    var immuneAgainst = [String]()
    
    private let margin: CGFloat = 16
    private let spacing: CGFloat = 8
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    func handleTypeLblTapped(_ sender: UITapGestureRecognizer) {
        
        if let typeLbl = sender.view as? TypeUILabel {
            self.type = typeLbl.text
            self.updateUI()
        }
    }
    
    func getWeaknesses() {
        
        if let weaknessesDict = CONSTANTS.weaknessesJSON[type] as? DictionarySS {
            for (type, effective) in weaknessesDict {
                switch effective {
                    
                case "2": //weak against
                    weakAgainst.append(type)
                    
                case "1/2": () //strong against
                    resistAgainst.append(type)
                    
                case "0": () //immune against
                    immuneAgainst.append(type)
                    
                default: () // value = ""
                }
            }
        }
    }
    
    func updateUI() {
        
        self.title = type
        
        getWeaknesses()
        
        configureTypeLbls(for: weakAgainstSectionLbl, withTypes: weakAgainst)
        configureTypeLbls(for: resistAgainstSectionLbl, withTypes: resistAgainst)
        configureTypeLbls(for: immuneAgainstSectionLbl, withTypes: immuneAgainst)
    }
    
    func configureTypeLbls(for sectionLbl: SectionUILabel, withTypes types: [String]) {
        
        var x: CGFloat = margin
        var y: CGFloat = sectionLbl.frame.origin.y + sectionLbl.frame.height + spacing
        
        if types.count > 0 {
            
            for type in types {
                let typeLbl: TypeUILabel = {
                    let label = TypeUILabel()
                    label.text = type
                    label.backgroundColor = UIColor.myColor.get(from: type)
                    label.frame.origin.x = x
                    label.frame.origin.y = y
                    
                    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTypeLblTapped(_:)))
                    label.addGestureRecognizer(tapGesture)
                    label.isUserInteractionEnabled = true
                    
                    return label
                }()
                
                sectionLbl.superview?.addSubview(typeLbl)
                
                x = x + typeLbl.frame.width + spacing
                
                if x + typeLbl.frame.width + spacing > sectionLbl.frame.width {
                    x = margin
                    y = y + typeLbl.frame.height + spacing
                }
            }
            
        } else {
            let noneLbl: TypeUILabel = {
                let label = TypeUILabel()
                label.text = "None"
                label.textColor = UIColor.myColor.sectionText
                label.backgroundColor = UIColor.myColor.ability
                label.frame.origin.x = x
                label.frame.origin.y = y
                
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTypeLblTapped(_:)))
                label.addGestureRecognizer(tapGesture)
                label.isUserInteractionEnabled = true
                
                return label
            }()
            
            sectionLbl.superview?.addSubview(noneLbl)
        }
    }
}
