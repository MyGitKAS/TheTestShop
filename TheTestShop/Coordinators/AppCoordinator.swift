//
//  AppCoordinator.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 19.03.24.
//

import UIKit

class AppCoordinator: Coordinator {
    
    let window: UIWindow
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var authCoordinator: AuthCoordinator?
    var rootCoordinator: RootCoordinator?

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let isLoggedIn = false
        if isLoggedIn {
            showRootCoordinator()
        } else {
            showAuthCoordinator()
        }
    }

   func showAuthCoordinator() {
        let authCoordinator = AuthCoordinator()
        self.authCoordinator = authCoordinator
        addChildCoordinator(authCoordinator)
        authCoordinator.start()
    }

  func showRootCoordinator() {
        if let authCoordinator = authCoordinator {
            removeChildCoordinator(authCoordinator)
            self.authCoordinator = nil
        }
        let rootCoordinator = RootCoordinator()
        self.rootCoordinator = rootCoordinator
        addChildCoordinator(rootCoordinator)
        rootCoordinator.start()
    }
}
