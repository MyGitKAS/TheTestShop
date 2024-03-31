//
//  AuthCoordinator.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 19.03.24.
//

import UIKit

final class AuthCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?

    func start() {
        let authViewController = AuthViewController(coordinator: self)
        (parentCoordinator as? AppCoordinator)?.window.rootViewController = authViewController
    }

    func showRootTabBar() {
        (parentCoordinator as? AppCoordinator)?.showRootCoordinator()
    }
}
