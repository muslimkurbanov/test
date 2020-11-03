//
//  Menu.swift
//  UICollectionView
//
//  Created by Муслим Курбанов on 22.10.2020.
//

import Foundation

struct Menu: Decodable {
    var brand : String
    var imageLink: String
    var title: String
    var price: Int
    var favorite: Bool
    var id: Int
    var count: Int? = 0
    var state: Bool? = false
}
