//
//  HomeController.swift
//  RadioApp
//
//  Created by Мария Нестерова on 29.07.2024.
//

import UIKit

final class HomeController: UITabBarController {
    private let presenter: HomePresenter
    
    init(presenter: HomePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        let popularVC = NavigationController(rootViewController: Builder.createPopular())
        popularVC.tabBarItem.title = "Popular".localized
        popularVC.view.backgroundColor = .darkBlueApp

        let favoriteVC = NavigationController(rootViewController: Builder.createFavorite())
        favoriteVC.tabBarItem.title = "Favorites".localized
        favoriteVC.view.backgroundColor = .darkBlueApp
        
        let allStationsVC = NavigationController(rootViewController: ViewController())
        allStationsVC.tabBarItem.title = "All Stations".localized
        allStationsVC.view.backgroundColor = .neonBlueApp
        
        viewControllers = [popularVC, favoriteVC, allStationsVC]
    }
}
