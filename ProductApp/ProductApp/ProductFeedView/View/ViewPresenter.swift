//
//  ViewPresentor.swift
//  ProductApp
//
//  Created by Dmitrii Sorochin on 16.03.2024.
//

import Foundation
import UIKit


final class ViewPresenter {
    private let network = NetworkService()
    private var products = [Product]()
    weak var controller: ProductFeed?
    
    func getData() -> [Product] {
        return products
    }
    
    func filterByPrice() {
        products.sort(by: { $0.price > $1.price })
        controller?.collectionViewContainer.reloadData()
    }
     
    func fetchProducts(page: Int ,pageSize: Int)  {
                
        network.fetchProducts(page: page, pageSize: pageSize) { [weak self] result in
            switch result {
            case .success(let responce):
                DispatchQueue.main.sync {
                    self?.products.append(contentsOf: responce.results)
                    self?.controller?.collectionViewContainer.reloadData()
                }
                case .failure(let error):
                DispatchQueue.main.sync {
                    self?.controller?.showNoInternetConnectionAllert()
                }
            }
        }
    }
}
