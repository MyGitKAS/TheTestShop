//
//  AuthCoordinator.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 19.03.24.
//

import Foundation

final class AuthCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?

    func start() {
        let authViewController = AuthViewController(coordinator: self)
        (parentCoordinator as? AppCoordinator)?.setRootViewController(authViewController)
    }

    func showRootTabBar() {
        (parentCoordinator as? AppCoordinator)?.showRootCoordinator()
    }
}
