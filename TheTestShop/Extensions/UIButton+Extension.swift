//
//  UIButton+Extension.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 28.03.24.
//

import UIKit

extension UIButton {
    static func cartButton(target: Any?, action: Selector) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: "cart"), for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.backgroundColor = Constants.mainColor
        let image = UIImage(systemName: "cart")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = Constants.elementCornerRadius
        return button
    }
}
