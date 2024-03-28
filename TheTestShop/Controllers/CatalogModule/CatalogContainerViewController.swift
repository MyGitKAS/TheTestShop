//
//  ContainerViewController.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 20.03.24.
//

import UIKit

class CatalogContainerViewController: UIViewController {
    
    private var isMenuOpen = false
    private let sideMenuViewController = SideMenuViewController()
    private let catalogViewController = CatalogViewController()
    private let dimmerView = UIView()
    private var menuButton: UIBarButtonItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCatalogViewController()
        setupDimmerView()
        setupSideMenuViewController()
    }
}

// MARK: - Private methods
private extension CatalogContainerViewController {

    @objc private func toggleMenu() {
        isMenuOpen = !isMenuOpen
        UIView.animate(withDuration: 0.3) {
            self.sideMenuViewController.view.frame.origin.x = self.isMenuOpen ? 0 : -self.view.bounds.width / 2
            self.dimmerView.alpha = self.isMenuOpen ? 1.0 : 0.0
            self.updateNavigationBarItems()
        }
    }

    func setupCatalogViewController() {
        addChild(catalogViewController)
        view.addSubview(catalogViewController.view)
        catalogViewController.didMove(toParent: self)
        catalogViewController.view.frame = view.bounds

        navigationItem.title = "Catalog"
        menuButton = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(toggleMenu))
        navigationItem.leftBarButtonItem = menuButton
    }

    func setupDimmerView() {
        dimmerView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        dimmerView.alpha = 0.0
        view.addSubview(dimmerView)
        dimmerView.frame = view.bounds
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleMenu))
        dimmerView.addGestureRecognizer(tapGesture)
    }

    func setupSideMenuViewController() {
        addChild(sideMenuViewController)
        view.addSubview(sideMenuViewController.view)
        sideMenuViewController.didMove(toParent: self)
        sideMenuViewController.view.frame = CGRect(x: -view.bounds.width / 2, y: 0, width: view.bounds.width / 2, height: view.bounds.height)
        sideMenuViewController.didSelectItem = { [weak self] category in
            guard let self = self else { return }
            self.catalogViewController.updateData(forCategory: category)
            self.toggleMenu()
        }
    }

    func updateNavigationBarItems() {
        navigationItem.leftBarButtonItem = isMenuOpen ? nil : menuButton
        navigationItem.title = isMenuOpen ? "" : "Catalog"
    }
}
