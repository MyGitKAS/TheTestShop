//
//  UIViewController+Extension .swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 27.03.24.
//

import UIKit

extension UIViewController {
    func showErrorAlert(withMessage message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(action)
            self.present(alertController, animated: true)
        }
    }
}
