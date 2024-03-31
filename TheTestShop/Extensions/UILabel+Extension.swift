//
//  UILabel+Extension.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 29.03.24.
//

import Foundation

import UIKit

extension UILabel {
    
    func errorLabel() {
        self.textColor = .red
        self.textAlignment = .center
        self.isHidden = true
    }
}
