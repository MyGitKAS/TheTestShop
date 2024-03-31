//
//  CustomTextField.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 19.03.24.
//

import UIKit

final class CustomTextField: UITextField {
    
    init(placeholder: String, isSecure: Bool = false) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.borderStyle = .roundedRect
        self.isSecureTextEntry = isSecure
        self.autocapitalizationType = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
