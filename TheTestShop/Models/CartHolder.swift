//
//  CartHolder.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 20.03.24.
//

import Foundation

struct CartHolder {

    static var products = Products()
    
    static func addProductInCart(_ product: Product) {
        products.append(product)
    }
    
    static func removeProductAtIndex(index: Int) {
        if products.indices.contains(index) {
            products.remove(at: index)
        }
    }
    
    static func removeAllProduct() {
        products.removeAll()
    }
}


