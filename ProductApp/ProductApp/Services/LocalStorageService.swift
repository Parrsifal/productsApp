//
//  LocalStorageService.swift
//  ProductApp
//
//  Created by Dmitrii Sorochin on 15.03.2024.
//

import Foundation

class LocalStorageService {
    
   private lazy var likedProducts = [Product]()

    
    func getProducts() -> [Product] {
        return [Product]()
    }
    
    func saveProduct(_ product: Product) {
        self.likedProducts.append(product)
    }
}

