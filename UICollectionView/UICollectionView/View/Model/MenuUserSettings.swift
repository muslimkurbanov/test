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
    private let menuKey = "MENU_PRODUCT"
    
    var dishesIds: [Int: Bool] {
        guard let decoded  = defaults.object(forKey: menuKey) as? Data else { return [:] }
        let array = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as? [Int: Bool]
        return array ?? [:]
    }
    
    func getDishCount(by id: Int) -> Bool? {
        return dishesIds[id]
    }
    
    func plusDishes(_ id: Int) {
        var dishesCopy = dishesIds
        if dishesCopy[id] == false {
            dishesCopy[id] = true
            print("dishesCopyId - \(dishesCopy[id])")
        } else {
            dishesCopy[id] = false
            print("dishesCopyId - \(dishesCopy[id])")
        }
        
        let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: dishesCopy, requiringSecureCoding: false)
        defaults.set(encodedData, forKey: menuKey)
    }
    
    
}

