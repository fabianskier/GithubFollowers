//
//  GFTabBarController.swift
//  GithubFollowers
//
//  Created by Oscar Cristaldo on 2022-08-05.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func createNavigationController(viewController: UIViewController, title: String, systemItem: UITabBarItem.SystemItem, tag: Int) -> UINavigationController {
        let navigationController = viewController
        navigationController.title = title
        navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: systemItem, tag: tag)
        
        return UINavigationController(rootViewController: navigationController)
    }
    
    func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        UITabBar.appearance().tintColor = .systemGreen
        tabBarController.viewControllers = [createNavigationController(viewController: SearchViewController(),
                                                                       title: "Search",
                                                                       systemItem: .search,
                                                                       tag: 0),
                                            createNavigationController(viewController: FavoritesListViewController(),
                                                                       title: "Favorites",
                                                                       systemItem: .favorites,
                                                                       tag: 1)]
        
        return tabBarController
    }
}
