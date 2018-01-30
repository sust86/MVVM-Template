//
//  Array+.swift
//  Learning
//
//  Created by Stefan Stumpfl on 12/21/15.
//  Copyright © 2015 LinkedIn. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {

    mutating func removeObject(_ object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }

    mutating func removeObjectsInArray(_ array: [Element]) {
        for object in array {
            removeObject(object)
        }
    }

    func takeElements(_ elementCount: Int) -> Array {
        var numElements = elementCount
        if numElements > count {
            numElements = count
        }
        return Array(self[0..<numElements])
    }
}

extension Collection {

    /**
     Returns the element at the specified index if it is within bounds, otherwise nil.
     */
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
