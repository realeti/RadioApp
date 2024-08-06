//
//  TabBarController.swift
//  RadioApp
//
//  Created by Мария Нестерова on 29.07.2024.
//

import UIKit
import SnapKit

final class TabBarController: UITabBarController {
    // MARK: - Private Properties
    private let audioPlayerVC = Builder.createAudioPlayer()
    
    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAudioPlayer()
        setupConstraints()
    }
    
    private func configure() {
        let popularVC = NavigationController(rootViewController: Builder.createPopular())
        popularVC.tabBarItem.title = "Popular".localized
        popularVC.view.backgroundColor = .darkBlueApp

        let favoriteVC = NavigationController(rootViewController: Builder.createFavorite())
        favoriteVC.tabBarItem.title = "Favorites"
        favoriteVC.view.backgroundColor = .darkBlueApp
        
        let allStationsVC = NavigationController(rootViewController: ViewController())
        allStationsVC.tabBarItem.title = "All Stations"
        allStationsVC.view.backgroundColor = .neonBlueApp
        
        viewControllers = [popularVC, favoriteVC, allStationsVC]
    }
}

// MARK: - Set AudioPlayer
private extension TabBarController {
    func setupAudioPlayer() {
        addChild(audioPlayerVC)
        view.addSubview(audioPlayerVC.view)
        audioPlayerVC.didMove(toParent: self)
    }
}

// MARK: - Setup Constraints
private extension TabBarController {
    func setupConstraints() {
        audioPlayerVC.view.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(tabBar.snp.top)
        }
    }
}
