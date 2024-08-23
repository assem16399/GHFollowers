//
//  GFTabBarController.swift
//  GHFollowers
//
//  Created by Aasem Hany on 18/08/2024.
//

import UIKit

class GFTabBarController: UITabBarController {


    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        let searchNC = createSearchNC()
        let favoritesNC = createFavoritesNC()
        // To customize the overall appearance (Theme) of the UITabBar (tintColor)
        UITabBar.appearance().tintColor = .systemGreen
        
        viewControllers = [searchNC, favoritesNC]
    }
    
    private func createSearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }

    private func createFavoritesNC() -> UINavigationController {
        let favoritesVC = FavoritesListVC()
        favoritesVC.title = "Favorites"
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favoritesVC)
    }

}
