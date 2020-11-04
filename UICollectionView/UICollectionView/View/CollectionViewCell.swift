//
//  CollectionViewCell.swift
//  UICollectionView
//
//  Created by Муслим Курбанов on 22.10.2020.
//

import UIKit
import SDWebImage
import Alamofire

protocol MenuCollentionViewCellDelegate: class {
    func orderAdded(_ order: Menu?)
    func orderDeleted(_ order: Menu)
}

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    
    var presenter: ViewPresetnerProtocol!
    var searchResponce: [Menu]? = nil
    var menu: Menu?
    private var cartManager = CartManager.shared
    private var order: Menu?
    private weak var delegate: MenuCollentionViewCellDelegate!
    
    func configurate(with model: Menu, delegate: MenuCollentionViewCellDelegate) {
        self.order = model
        self.delegate = delegate
    
        order?.state = cartManager.getDishCount(by: model.id)
        nameLabel.text = model.brand
        priceLabel.text = "\(model.price) ₽"
        titleLabel.text = model.title
        imageView.sd_setImage(with: URL(string: model.imageLink), completed: nil)
        
        if order?.state ?? true {
            selectButton.isSelected = order?.state ?? false
        } else {
            
            selectButton.isSelected = order?.state ?? true
        }
    }

    @IBAction func addToCartButton(_ sender: Any) {

        
        if selectButton.isSelected == false {
            
            guard let order = self.order else { return }
            cartManager.plusDishes(order.id)

            self.order?.state = true

            selectButton.isSelected = order.state ?? true
            print(order.state ?? 0)
            
        } else {
            
            guard let order = self.order else { return }
            cartManager.plusDishes(order.id ?? 0)
            
            self.order?.state = false
            selectButton.isSelected = order.state ?? false
            print(order.state ?? 0)

        }
    }
}
