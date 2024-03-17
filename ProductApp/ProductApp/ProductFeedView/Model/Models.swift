//
//  Models.swift
//  ProductApp
//
//  Created by Dmitrii Sorochin on 15.03.2024.
//

import Foundation

struct Category: Codable {
    let id: Int
}

struct Product: Codable {
    let category: Category
    let name: String
    let details: String
    let size: String
    let colour: String
    let price: Double
    let mainImage: String
    let id: Int
}

struct ProductResponse: Codable {
    let count: Int
    let totalPages: Int
    let perPage: Int
    let currentPage: Int
    let results: [Product]
    
    
}



