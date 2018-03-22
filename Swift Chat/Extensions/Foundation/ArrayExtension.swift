//
//  ArrayExtension.swift
//  Swiftly Chat
//
//  Created by Alexander Khitev on 3/22/18.
//  Copyright © 2018 Alexander Khitev. All rights reserved.
//

import Foundation

extension Array where Element : Equatable {
    
    var unique: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            if !uniqueValues.contains(item) {
                uniqueValues += [item]
            }
        }
        return uniqueValues
    }
    
    var removeRepetingItems: [Element] {
        var uniqueValues: [Element] = []
        var repeatValues: [Element] = []
        forEach { item in
            if !uniqueValues.contains(item) && !repeatValues.contains(item) {
                uniqueValues += [item]
            } else {
                // repeat
                repeatValues.append(item)
                if let index = uniqueValues.index(of: item) {
                    uniqueValues.remove(at: index)
                }
            }
        }
        return uniqueValues
    }
    
    func filterDuplicate<T>(_ keyValue: (Element) -> T) -> [Element] {
        var uniqueKeys = Set<String>()
        return filter { uniqueKeys.insert("\(keyValue($0))").inserted }
    }

    
}
