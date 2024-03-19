//
//  RootCoordinator.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 19.03.24.
//

import UIKit

class RootCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    let tabBarController: UITabBarController

    init() {
        self.tabBarController = RootTabBarViewController()
    }

    func start() {
        (parentCoordinator as? AppCoordinator)?.window.rootViewController = tabBarController
    }
}
