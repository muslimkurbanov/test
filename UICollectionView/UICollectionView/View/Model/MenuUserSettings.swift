//
//  MenuUserSettings.swift
//  UICollectionView
//
//  Created by Муслим Курбанов on 25.10.2020.
//

import Foundation

class CartManager {
    static let shared = CartManager()
    private init() {}
    
    private let defaults = UserDefaults.standard
    private let menuKey = "LIKE_PRODUCT"
    
    var dishesIds: [Int] {
        let array  = defaults.object(forKey: menuKey) as? [Int]
//        let array = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as? [Int]
        return array ?? []
    }
    
    func addToFavoriteProduct(_ id: Int) -> Bool {
        return dishesIds.contains(id)
    }
    
    func selectFavorite(by id: Int) -> Bool {
        var added: Bool
        var dishesCopy = dishesIds
        
        if dishesCopy.contains(id), let index = dishesCopy.firstIndex(of: id) {
            dishesCopy.remove(at: index)
            added = false
        } else {
            dishesCopy.append(id)
            added = true
        }
        defaults.set(dishesCopy, forKey: menuKey)
        return added
    }
    
    
}

