//
//  ArrayExtensions.swift
//  GameGo
//
//  Created by Amjad Tubasi on 1/8/18.
//  Copyright © 2018 Amjad Tubasi. All rights reserved.
//

import Foundation

public extension Array {
    public func grouped<T>(by criteria: (Element) -> T) -> [T: [Element]] {
        var groups = [T: [Element]]()
        for element in self {
            let key = criteria(element)
            if groups.keys.contains(key) == false {
                groups[key] = [Element]()
            }
            groups[key]?.append(element)
        }
        return groups
    }
}



