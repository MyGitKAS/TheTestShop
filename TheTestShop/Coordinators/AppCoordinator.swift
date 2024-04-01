//
//  AppCoordinator.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 19.03.24.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    private var authCoordinator: AuthCoordinator?
    private var rootCoordinator: RootCoordinator?
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let isLoggedIn = FirebaseAuthManager.shared.isUserLoggedIn()
        if isLoggedIn {
            showRootCoordinator()
        } else {
            showAuthCoordinator()
        }
    }
    
    func logout() {
        self.removeAllChildCoordinators()
        self.start()
    }

    func showAuthCoordinator() {
        let authCoordinator = AuthCoordinator()
        self.authCoordinator = authCoordinator
        addChildCoordinator(authCoordinator)
        authCoordinator.parentCoordinator = self
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
        rootCoordinator.parentCoordinator = self
        rootCoordinator.start()
    }
    
    func setRootViewController(_ viewController: UIViewController) {
        window.rootViewController = viewController
    }
}
