//
//  PersistenceManager.swift
//  Impromptu
//
//  Created by Dedi Prakasa on 5/28/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

class PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func getFavorites() -> [Int] {
        
        guard let favoritesIndex = defaults.object(forKey: Keys.favorites) as? [Int] else {
            return []
        }
        
        return favoritesIndex
    }
    
    static func update(favoriteIndex: Int, type: PersistenceActionType, completion: @escaping ([Int]?) -> Void) {
        var fi = getFavorites()
        switch type {
        case .add:
            if fi.contains(favoriteIndex) { return }
            fi.append(favoriteIndex)
        case .remove:
            fi.removeAll { $0 == favoriteIndex }
        }
        
        save(favoritesIndex: fi)
        completion(fi)
        
    }
    
    static func save(favoritesIndex: [Int]) {
        defaults.set(favoritesIndex, forKey: Keys.favorites)
    }
}
