//
//  Endpoint.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 19.03.24.
//

import Foundation

enum ShopApiEndpoint {
    case addUser(userData: [String: Any])
    case getProductsInCategory(categoryId: Int)
    case getAllCategories
    case getSingleProduct(productId: Int)
    case getAllProducts
    case getUser(userId: Int)
    
    private var baseURL: URL {
        return URL(string: "https://fakestoreapi.com")!
    }

    var url: URL {
        switch self {
        case .addUser:
            return baseURL.appendingPathComponent("/users")
        case .getProductsInCategory(let categoryId):
            return baseURL.appendingPathComponent("/products/category/\(categoryId)")
        case .getAllCategories:
            return baseURL.appendingPathComponent("/products/categories")
        case .getSingleProduct(let productId):
            return baseURL.appendingPathComponent("/products/\(productId)")
        case .getAllProducts:
            return baseURL.appendingPathComponent("/products")
        case .getUser(let userId):
            return baseURL.appendingPathComponent("/users/\(userId)")
        }
    }
        
    var httpMethod: String {
        switch self {
        case .addUser:
            return "POST"
        default:
            return "GET"
        }
    }

    var httpBody: Data? {
        switch self {
        case .addUser(let userData):
            return try? JSONSerialization.data(withJSONObject: userData, options: [])
        default:
            return nil
        }
    }
}
