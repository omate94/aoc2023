//
//  Array+Extensions.swift
//  aoc2023
//
//  Created by Mate Olah on 2023. 12. 11..
//

import Foundation

extension Array where Element : Collection {
    func getColumn(column : Element.Index) -> [ Element.Iterator.Element ] {
        return self.map { $0[ column ] }
    }
}

extension Array where Element: RangeReplaceableCollection, Element.Index == Index {
    mutating func insert(_ elements: Element, column: Index) {
        for index in indices {
            self[index].insert(elements[index], at: column)
        }
    }
}

extension Array where Element: Hashable {
    func duplicates() -> Array {
        let groups = Dictionary(grouping: self, by: {$0})
        let duplicateGroups = groups.filter {$1.count > 1}
        let duplicates = Array(duplicateGroups.keys)
        return duplicates
    }
}
