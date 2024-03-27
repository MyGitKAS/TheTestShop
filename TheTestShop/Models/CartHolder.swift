//
//  CartHolder.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 20.03.24.
//

import Foundation

struct CartHolder {
    
    static var products: Products = fakeProducts
    
    static func addProductInCart(_ product: Product) {
     //TODO: -
    }
}


let fakeProducts = [Product(id: 1, title: "Example Product", price: 99.99, description: "This is a sample description.", category: .electronics,                     image: "https://image.png", rating: Rating(rate: 4.5, count: 100)),
                    Product(id: 2, title: "Example Product", price: 99.99, description: "This is a sample description.", category: .electronics, image: "https://image.png", rating: Rating(rate: 4.5, count: 100)),
                    Product(id: 3, title: "Example Product", price: 99.99, description: "This is a sample description.", category: .electronics, image: "https://image.png", rating: Rating(rate: 4.5, count: 100)),
                    Product(id: 4, title: "Example Product", price: 99.99, description: "This is a sample description.", category: .electronics, image: "https://image.png", rating: Rating(rate: 4.5, count: 100)),
                    Product(id: 5, title: "Example Product", price: 99.99, description: "This is a sample description.", category: .electronics, image: "https://image.png", rating: Rating(rate: 4.5, count: 100)),
        ]

