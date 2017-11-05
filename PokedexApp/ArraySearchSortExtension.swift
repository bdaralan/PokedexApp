//
//  ArraySearchSortExtensionswift
//  PokedexApp
//
//  Created by Dara on 10/20/17.
//  Copyright © 2017 iDara09. All rights reserved.
//

import Foundation

extension Array where Element: Comparable {
    
    // MARK: - Binary Search
    
    public func binarySearch(for element: Element) -> Element? {
        guard self.count > 0 else { return nil }
        var lowIndex = 0
        var highIndex = self.count - 1
        var midIndex = highIndex / 2
        while midIndex <= highIndex {
            midIndex = (lowIndex + highIndex) / 2
            guard element != self[midIndex] else { return self[midIndex] }
            switch element < self[midIndex] {
            case true: highIndex = midIndex - 1
            case false: lowIndex = midIndex + 1
            }
        }
        return nil
    }
    
    // MARK: - Merge Sort
    
    public func mergeSort() -> [Element] {
        guard self.count > 1 else { return self }
        
        // split
        let lhs = Array(self[0 ..< self.count / 2])
        let rhs = Array(self[self.count / 2 ..< self.count])
        
        // merge
        return mergeAndSort(lhs: lhs.mergeSort(), rhs: rhs.mergeSort())
    }
    
    private func mergeAndSort(lhs: [Element], rhs: [Element]) -> [Element] {
        var lhs = lhs
        var rhs = rhs
        var mergedArray = [Element]()
        
        // sorting
        while lhs.count > 0, rhs.count > 0 {
            switch lhs.first! < rhs.first! {
            case true: mergedArray.append(lhs.removeFirst())
            case false: mergedArray.append(rhs.removeFirst())
            }
        }
        return mergedArray + lhs + rhs
    }
}
