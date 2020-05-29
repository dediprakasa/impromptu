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
    
    static func update(favoriteIndex: Int, completion: @escaping ([Int]?) -> Void) {
        print(defaults.object(forKey: Keys.favorites) as? [Int])
        var fi = getFavorites()
        print(fi,"\\\\")
        if fi.contains(favoriteIndex) {
            return
        }
        
        fi.append(favoriteIndex)
        save(favoritesIndex: fi)
        print(defaults.object(forKey: Keys.favorites) as? [Int], "???")

        completion(fi)
        
    }
    
    static func save(favoritesIndex: [Int]) {
        defaults.set(favoritesIndex, forKey: Keys.favorites)
    }
}
