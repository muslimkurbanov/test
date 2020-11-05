//
//  CollectionViewCell.swift
//  UICollectionView
//
//  Created by Муслим Курбанов on 22.10.2020.
//

import UIKit
import SDWebImage
import Alamofire

class CollectionViewCell: UICollectionViewCell {
    
    private var cartManager = CartManager.shared
    private var id: Int!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addToFavoriteImage: UIButton!
    
     var isLiked: Bool = false {
            didSet {
                toggleProduct()
            }
        }
    
    func configurate(with model: Menu, _ isLiked: Bool) {
        self.id = model.id
        self.isLiked = isLiked
            
        nameLabel.text = model.brand
        priceLabel.text = "\(model.price) ₽"
        titleLabel.text = model.title
        imageView.sd_setImage(with: URL(string: model.imageLink), completed: nil)
    }

    @IBAction func addToCartButton(_ sender: UIButton) {
        print("1")
        let change = cartManager.selectFavorite(by: id)
        isLiked = change
    }
    func toggleProduct() {
        let imageName = isLiked ? "fillHeart" : "heart"
//        addToFavoriteImage?.setBackgroundImage(UIImage(named: imageName), for: .normal)
        addToFavoriteImage.setImage(UIImage(named: imageName), for: .normal)
    }
}
