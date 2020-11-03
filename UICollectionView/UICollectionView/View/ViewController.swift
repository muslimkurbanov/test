//
//  ViewController.swift
//  UICollectionView
//
//  Created by Муслим Курбанов on 22.10.2020.
//

import UIKit
import SDWebImage

protocol ViewProtocol: class {
    func applyData(model: [Menu])
    func failure(error: Error)
}

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var searchResponse = [Menu]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var presenter: ViewPresetnerProtocol!
    private let cartManager = CartManager.shared
    
//    var itemMenuArray: [Menu] = {
//        var blankMenu = Menu()
//        blankMenu.brand = "CocaCola"
//        blankMenu.imageLink = "cola"
//        print("blankMenu")
//        return [blankMenu]
//        
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MainViewPresenter(view: self)

        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return searchResponse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as! CollectionViewCell
        let item = searchResponse[indexPath.row]
        let count = cartManager.getDishCount(by: item.id)
        cell.configurate(with: item, delegate: self)
        
        return cell
    }
    
    
}

extension ViewController: ViewProtocol {
    func applyData(model: [Menu]) {
        searchResponse.append(contentsOf: model)
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

extension ViewController: MenuCollentionViewCellDelegate {
    func orderAdded(_ order: Menu?) {
        guard cartManager.dishesIds.count < 2 else { return }

    }
    
    func orderDeleted(_ order: Menu) {
        guard cartManager.dishesIds.count == 0 else { return }

    }
    
    
}
