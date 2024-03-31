//
//  ValidationError.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 31.03.24.
//

import Foundation

enum ValidationError: String {
    case emptyFields = "Please fill in all fields."
    case invalidEmail = "Invalid email address."
    case incorrectPassword = "Password must contain at least one letter and one digit at least 8 characters long"
    case passwordMismatch = "Passwords do not match."
    case invalidPassword = "Please enter your password."
}

