//
//  PokeEvolutionCV.swift
//  PokedexApp
//
//  Created by Dara Beng on 11/21/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import UIKit

/// Use with PokeEvolutionCell. Will be fill into its `contentView` to display Pokemon's evolutions.
class PokeEvolutionCV: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private var numberOfItemPerColmn = 3
    private var numberOfItemPerRow = 3
    private var sizeForItem: CGSize = .zero
    
    public var isConstraintToSuperviewBound: Bool = false
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        configureCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureCollectionView()
    }
    
    // MARK: - Function
    
    private func configureCollectionView() {
        delegate = self
        dataSource = self
        backgroundColor = nil
        isScrollEnabled = false
        register(PokeEvolutionCollectionCell.self, forCellWithReuseIdentifier: "\(PokeEvolutionCollectionCell.self)")
    }
    
    public static var defaultLayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return layout
    }
    
    /// Call to update `itemSize` when change `numberOfItemPerRow` or `numberOfItemPerColumn`.
    public func updateSizeForItem() {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let hInsetSpace = layout.sectionInset.left + layout.sectionInset.right
        let vInsetSpace = layout.sectionInset.top + layout.sectionInset.bottom
        let numberOfItemPerRow = CGFloat(self.numberOfItemPerRow)
        let numberOfItemPerColumn = CGFloat(self.numberOfItemPerColmn)
        
        let width = (bounds.width - (layout.minimumInteritemSpacing * (numberOfItemPerColumn - 1)) - hInsetSpace) / numberOfItemPerColumn
        let height = (bounds.height - (layout.minimumLineSpacing * (numberOfItemPerRow - 1)) - vInsetSpace) / numberOfItemPerRow
        sizeForItem = CGSize(width: width.rounded(.down), height: height.rounded(.down))
    }
    
    // MARK: - Delegate and Datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItemPerColmn * numberOfItemPerRow
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "\(PokeEvolutionCollectionCell.self)", for: indexPath)
        cell.contentView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.sizeForItem.height == 0 { updateSizeForItem() }
        return self.sizeForItem
    }
}
