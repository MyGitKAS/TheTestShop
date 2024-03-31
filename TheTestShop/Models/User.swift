//
//  User.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 19.03.24.
//

import Foundation

// MARK: - User
struct User: Codable {
    var email: String
    var username: String
    var password: String
    var name: Name
    var address: Address
    var phone: String
    
    func toDictionary() -> [String: Any] {
           return [
               "email": email,
               "username": username,
               "password": password,
               "name": [
                   "firstname": name.firstname,
                   "lastname": name.lastname
               ],
               "address": [
                   "city": address.city,
                   "street": address.street,
                   "number": address.number,
                   "zipcode": address.zipcode,
                   "geolocation": [
                       "lat": address.geolocation.lat,
                       "long": address.geolocation.long
                   ]
               ],
               "phone": phone
           ]
       }
}
// MARK: - Name
struct Name: Codable {
    var firstname: String
    var lastname: String
}

// MARK: - Address
struct Address: Codable {
    var city: String
    var street: String
    var number: Int
    var zipcode: String
    var geolocation: Geolocation
}

// MARK: - Geolocation
struct Geolocation: Codable {
    var lat: String
    var long: String
}

