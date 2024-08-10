//
//  HomeController.swift
//  RadioApp
//
//  Created by Мария Нестерова on 29.07.2024.
//

import UIKit
import SnapKit

final class HomeController: UITabBarController {
    private let presenter: HomePresenter
    private let audioPlayerVC = Builder.createAudioPlayer()
    
    var playerIsHidden: Bool {
        get { audioPlayerVC.view.isHidden }
        set { audioPlayerVC.view.isHidden = newValue }
    }
    
    var volumeIsHidden: Bool {
        get {
            if let volumeView = audioPlayerVC.view.subviews.first(where: { $0 is VerticalVolumeView }) as? VerticalVolumeView {
                return volumeView.isHidden
            }
            return false
        }
        set {
            if let volumeView = audioPlayerVC.view.subviews.first(where: { $0 is VerticalVolumeView }) as? VerticalVolumeView {
                volumeView.isHidden = newValue
            }
        }
    }
    
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
        setupAudioPlayer()
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

// MARK: - Set AudioPlayer
private extension HomeController {
    func setupAudioPlayer() {
        addChild(audioPlayerVC)
        view.addSubview(audioPlayerVC.view)
        audioPlayerVC.didMove(toParent: self)
        
        audioPlayerVC.view.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
