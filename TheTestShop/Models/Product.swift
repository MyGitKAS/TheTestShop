//
//  Product.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 19.03.24.
//
import Foundation

typealias Products = [Product]
typealias Categories = [String]

// MARK: - Product
struct Product: Codable {
    let id: Int?
    let title: String?
    let price: Double?
    let description: String?
    let category: Category
    let image: String?
    let rating: Rating
}

// MARK: - Category
enum Category: String, Codable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's clothing"
    case womenSClothing = "women's clothing"
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double
    let count: Int
}

