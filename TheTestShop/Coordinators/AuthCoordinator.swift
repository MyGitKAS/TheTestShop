//
//  AuthCoordinator.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 19.03.24.
//

import UIKit

class AuthCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    let navigationController: UINavigationController

    init() {
        self.navigationController = UINavigationController()
    }

    func start() {
        let authViewController = AuthViewController(coordinator: self)
        navigationController.setViewControllers([authViewController], animated: false)
        (parentCoordinator as? AppCoordinator)?.window.rootViewController = navigationController
    }

    func showRootTabBar() {
        (parentCoordinator as? AppCoordinator)?.showRootCoordinator()
    }
}
