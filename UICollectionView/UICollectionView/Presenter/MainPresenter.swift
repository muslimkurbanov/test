//
//  MainPresenter.swift
//  UICollectionView
//
//  Created by Муслим Курбанов on 25.10.2020.
//

import Foundation

protocol ViewPresetnerProtocol: class {
    init(view: ViewProtocol)
    func getMenu()
}

final class MainViewPresenter: ViewPresetnerProtocol {
    
    private var searchResponce: [Menu]? = nil
    private var main = ViewController()
    private let networkService: NetworkServiceProtocol = NetworkService()
    
    private weak var view: ViewProtocol?
    
    required init(view: ViewProtocol) {
        self.view = view
        self.getMenu()
    }

    func getMenu() {
        
        networkService.getMenu { [weak self] result in
            
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let searchResponce):
                    
                    self.searchResponce = searchResponce
                    self.view?.applyData(model: searchResponce!)
                    
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
}
