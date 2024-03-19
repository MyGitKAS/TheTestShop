//
//  Constants.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 19.03.24.
//

import UIKit

struct Constants {
    static let mainColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
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
            return 10
        case .medium:
            return 14
        case .large:
            return 18
        case .extraLarge:
            return 25
        }
    }
}
