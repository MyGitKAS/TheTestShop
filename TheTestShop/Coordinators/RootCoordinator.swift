//
//  RootCoordinator.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 19.03.24.
//

import UIKit

final class RootCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    lazy var tabBarController: UITabBarController = {
        let tabBarController = RootTabBarViewController(coordinator: self)
        return tabBarController
    }()

    func start() {
        let tabBarController = self.tabBarController
        (parentCoordinator as? AppCoordinator)?.setRootViewController(tabBarController)
    }
    
    func didRequestLogout() {
        (parentCoordinator as? AppCoordinator)?.logout()
    }
}

