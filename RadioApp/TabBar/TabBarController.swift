//
//  TabBarController.swift
//  RadioApp
//
//  Created by Мария Нестерова on 29.07.2024.
//

import UIKit

final class TabBarController: UITabBarController {
    init() {
        super.init(nibName: nil, bundle: nil)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        let popularVC = NavigationController(rootViewController: Builder.createPopular())
        popularVC.tabBarItem.title = "Popular"
        popularVC.view.backgroundColor = .darkBlueApp

        let favoriteVC = NavigationController(rootViewController: Builder.createFavorite())
        favoriteVC.tabBarItem.title = "Favorites"
        favoriteVC.view.backgroundColor = .darkBlueApp
        
        let allStationsVC = NavigationController(rootViewController: ViewController())
        allStationsVC.tabBarItem.title = "All Stations"
        allStationsVC.view.backgroundColor = .darkBlueApp
        
        viewControllers = [popularVC, favoriteVC, allStationsVC]
    }
}
