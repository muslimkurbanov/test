//
//  CartViewController.swift
//  UICollectionView
//
//  Created by Муслим Курбанов on 27.10.2020.
//

import UIKit

class CartViewController: UIViewController {
    
    override func viewDidLoad() {
        
    }
    @IBAction func popViewControllerButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
