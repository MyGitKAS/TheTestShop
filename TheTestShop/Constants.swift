//
//  Constants.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 19.03.24.
//

import UIKit

struct Constants {
    static let mainColor = #colorLiteral(red: 0.7957445271, green: 0, blue: 1, alpha: 1)
    static let elementCornerRadius: CGFloat = 10
}

enum TextSize {
    case small
    case medium
    case large
    case extraLarge

    func getSize() -> CGFloat {
        switch self {
        case .small:
            return 12
        case .medium:
            return 16
        case .large:
            return 20
        case .extraLarge:
            return 28
        }
    }
}
