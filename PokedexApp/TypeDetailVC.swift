//
//  TypeDetailVC.swift
//  PokedexApp
//
//  Created by Dara on 4/30/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

class TypeDetailVC: UIViewController {
    
    @IBOutlet weak var weakToSectionLbl: SectionUILabel!
    @IBOutlet weak var resistToSectionLbl: SectionUILabel!
    @IBOutlet weak var immuneToSectionLbl: SectionUILabel!
    
    @IBOutlet weak var weakToView: UIView!
    @IBOutlet weak var resistToView: UIView!
    @IBOutlet weak var immuneToView: UIView!
    
    
    var type: String! //will be assigned by segue
    var weakToTypes = [String]()
    var resistToTypes = [String]()
    var immuneToTypes = [String]()
    
    private let margin: CGFloat = 16
    private let spacing: CGFloat = 8
    
    private let cache = NSCache<AnyObject, AnyObject>()
    private var allTypeLabels = [[TypeUILabel](), [TypeUILabel](), [TypeUILabel]()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weakToView.tag = 0
        resistToView.tag = 1
        immuneToView.tag = 2
        
        updateUI()
        
        cache.setObject(type as AnyObject, forKey: type as AnyObject)
    }
    
    func handleTypeLblTapped(_ sender: UITapGestureRecognizer) {
        
        if let typeLbl = sender.view as? TypeUILabel, self.title != typeLbl.text {
            self.type = typeLbl.text
            self.updateUI()
        }
    }
    
    func getWeaknesses() {
        
        if let cachedWeakToTypes = cache.object(forKey: "weakToTypes\(type)" as AnyObject) as? [String],
            let cachedResistToTypes = cache.object(forKey: "resisToTypes\(type)" as AnyObject) as? [String],
            let cachedImmuneToTypes = cache.object(forKey: "immuneToTypes\(type)" as AnyObject) as? [String] {
            
            weakToTypes = cachedWeakToTypes
            resistToTypes = cachedResistToTypes
            immuneToTypes = cachedImmuneToTypes
            
        } else {
            if let weaknessesDict = CONSTANTS.weaknessesJSON[type] as? DictionarySS {
                for (type, effective) in weaknessesDict {
                    switch effective {
                        
                    case "2": //weak against
                        weakToTypes.append(type)
                        
                    case "1/2": //strong against
                        resistToTypes.append(type)
                        
                    case "0": //immune against
                        immuneToTypes.append(type)
                        
                    default: () // value = ""
                    }
                }
            }
            
            self.cache.setObject(weakToTypes as AnyObject, forKey: "weakToTypes\(type)" as AnyObject)
            self.cache.setObject(resistToTypes as AnyObject, forKey: "resisToTypes\(type)" as AnyObject)
            self.cache.setObject(immuneToTypes as AnyObject, forKey: "immuneToTypes\(type)" as AnyObject)
        }
    }
    
    func updateUI() {
        
        self.title = type
        
        setDefaultState()
        getWeaknesses()
        
        configureTypeLbls(for: weakToView, withTypes: weakToTypes)
        weakToView.sizeToContent()
        
        resistToSectionLbl.setOriginBelow(weakToView, spacing: 29)
        
        configureTypeLbls(for: resistToView, withTypes: resistToTypes)
        resistToView.setOriginBelow(resistToSectionLbl)
        resistToView.sizeToContent()
        
        immuneToSectionLbl.setOriginBelow(resistToView, spacing: 29)
        
        configureTypeLbls(for: immuneToView, withTypes: immuneToTypes)
        immuneToView.setOriginBelow(immuneToSectionLbl)
        immuneToView.sizeToContent()
        
        self.cache.setObject(allTypeLabels as AnyObject, forKey: "allTypeLabels\(type)" as AnyObject)
    }
    
    func setDefaultState() {
        
        weakToView.removeAllSubviews()
        resistToView.removeAllSubviews()
        immuneToView.removeAllSubviews()
        
        weakToTypes.removeAll()
        resistToTypes.removeAll()
        immuneToTypes.removeAll()
        
        for i in 0 ..< allTypeLabels.count {
            allTypeLabels[i].removeAll()
        }
    }
    
    func configureTypeLbls(for view: UIView, withTypes types: [String]) {
        
        if let cachedAllTypeLabels = cache.object(forKey: "allTypeLabels\(type)" as AnyObject) as? [[TypeUILabel]] {
            allTypeLabels = cachedAllTypeLabels
            for label in allTypeLabels[view.tag] {
                view.addSubview(label)
            }
            
        } else {
            var x: CGFloat = margin
            var y: CGFloat = 0
            
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
                    
                    view.addSubview(typeLbl)
                    
                    allTypeLabels[view.tag].append(typeLbl)
                    
                    x = x + typeLbl.frame.width + spacing
                    
                    if x + typeLbl.frame.width + spacing > view.frame.width - spacing {
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
                    
                    return label
                }()
                
                view.addSubview(noneLbl)
                
                allTypeLabels[view.tag].append(noneLbl)
            }
        }
    }
}
