//
//  RootTabBarViewController.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 19.03.24.
//

import UIKit

final class RootTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = Constants.mainColor
        self.tabBar.backgroundColor = .darkGray
        
        let firstViewController = HomeViewController()
        let firstNavController = UINavigationController(rootViewController: firstViewController)
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 0)

        let secondViewController = ContainerViewController()
        let secondNavController = UINavigationController(rootViewController: secondViewController)
        secondNavController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)

        let thirdViewController = UIViewController()
        let thirdNavController = UINavigationController(rootViewController: thirdViewController)
        thirdNavController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 2)

        let fourthViewController = UIViewController()
        let fourthNavController = UINavigationController(rootViewController: fourthViewController)
        fourthViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts , tag: 3)
        
        self.viewControllers = [firstNavController, secondNavController, thirdNavController, fourthNavController]
    }
}
