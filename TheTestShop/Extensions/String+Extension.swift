//
//  String+Extension.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 30.03.24.
//

import Foundation

extension String {

    enum ValidTypes {
        case name
        case email
        case password
    }

    enum Regex: String {
        case name = "[a-zA-Z]{1,}"
        case email = "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}"
        case password = "(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}"
    }

    func isValid(validType: ValidTypes) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""

        switch validType {
        case .name:
            regex = Regex.name.rawValue
        case .email:
            regex = Regex.email.rawValue
        case .password:
            regex = Regex.password.rawValue
        }

        return NSPredicate(format: format, regex).evaluate(with: self)
    }
}
