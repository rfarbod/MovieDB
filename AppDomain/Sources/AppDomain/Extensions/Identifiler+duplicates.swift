//
//  File.swift
//  
//
//  Created by Farbod Rahiminik on 9/14/24.
//

import Foundation

extension Array where Element: Identifiable {
    public func removeDuplicates() -> [Element] {
        var seen = Set<Element.ID>()
        return self.filter { element in
            guard !seen.contains(element.id) else {
                return false
            }
            seen.insert(element.id)
            return true
        }
    }
}
