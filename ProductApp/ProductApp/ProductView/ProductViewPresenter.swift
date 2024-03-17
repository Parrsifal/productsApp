//
//  ProductViewPresenter.swift
//  ProductApp
//
//  Created by Dmitrii Sorochin on 16.03.2024.
//

import Foundation

final class ProductViewPresenter {
    private let networkService = NetworkService()
    var product: Product?
    weak var controller: ProductViewController?
    
    
    func fetchProduct(id: Int)  {
        
        networkService.fetchProduct(id: id) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.sync {
                    self?.product = response
                    self?.controller?.updateData()
                }
            case .failure(let error):
                print("error")
            }
        }
    }
}
