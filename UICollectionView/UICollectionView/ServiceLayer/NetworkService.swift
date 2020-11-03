//
//  NetworkService.swift
//  UICollectionView
//
//  Created by Муслим Курбанов on 23.10.2020.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
//    func getComments(completion: @escaping (Result<[Model]?, Error>) -> Void)
    func getMenu(complletion: @escaping (Result<[Menu]?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func getMenu(complletion: @escaping (Result<[Menu]?, Error>) -> Void) {
        //section=21
        let urlString = "https://idillika.com/api/catalogList.php?section=22&session_id=f3e82db3d0b2bcce07eae17dd9cb46d3"
        
        AF
            .request(urlString, method: .get, parameters: nil)
            .responseJSON { (response) in
                switch response.result {
                case .failure(let error):
                    print(error)
                case .success(let value):
                    if let arrayDictionary = value as? [[String: Any]] {
                        do {
                            let data = try JSONSerialization.data(withJSONObject: arrayDictionary, options: .fragmentsAllowed)
                            print(data)
//                            let decoder = JSONDecoder()
//                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let result = try JSONDecoder().decode([Menu].self, from: data)
                            complletion(.success(result))
                            print(result)
                        } catch {
                            complletion(.failure(error))
                            print(error)
                        }
                    }
                }
            }.resume()
    }
    
}
