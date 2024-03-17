//
//  NetworkService.swift
//  ProductApp
//
//  Created by Dmitrii Sorochin on 16.03.2024.
//

import Foundation
import Kingfisher

enum Endpoints {
    case getProducts(page: Int, pageSize: Int)
    case getProductById(id: Int)
    
    var urlString: String {
        switch self {
        case .getProducts(let page, let pageSize):
            return "http://mobile-shop-api.hiring.devebs.net/products?page=\(page)&page_size=\(pageSize)"
        case .getProductById(let id):
            return "http://mobile-shop-api.hiring.devebs.net/products/\(id)"
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse(Int)
    case noData
}

final class NetworkService {
    
    func fetchProduct(id: Int, completion: @escaping (Result<Product, Error>) -> Void) {

        //For some reasons does not work like in fetchProducts with enum 
        let uri = URL(string: "http://mobile-shop-api.hiring.devebs.net/products/\(id)")
        
        URLSession.shared.dataTask(with: uri!) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                completion(.failure(NetworkError.invalidResponse(httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let productResponse = try decoder.decode(Product.self, from: data)
                
                completion(.success(productResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchProducts(page: Int, pageSize: Int, completion: @escaping (Result<ProductResponse, Error>) -> Void) {

        guard let url = URL(string: Endpoints.getProducts(page: page, pageSize: pageSize).urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

         URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                completion(.failure(NetworkError.invalidResponse(httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let productResponse = try decoder.decode(ProductResponse.self, from: data)
                
                completion(.success(productResponse))
            } catch {
                completion(.failure(error))
            }
         }.resume()
        
        // Start the data task
    }
}
