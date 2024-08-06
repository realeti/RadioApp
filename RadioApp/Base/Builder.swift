//
//  Builder.swift
//  RadioApp
//
//  Created by Мария Нестерова on 29.07.2024.
//

import UIKit

final class Builder {
    
    static func createTabBar() -> UIViewController {
        TabBarController()
    }
    
    static func createAuthorization() -> UIViewController {
        AuthorizationAssembly().build()
    }
    
    static func createPopular() -> UIViewController {
        PopularAssembly().build()
    }

    static func createFavorite() -> UIViewController {
        FavoritesAssembly().build(router: FavoritesRouter())
    }
//
//    static func createSearch() -> UIViewController {
//
//    }
//
    static func createProfile() -> UIViewController {
        let view = ProfileViewController()
        let router = ProfileRouter()
        router.controller = view
//        let realmService = RealmService()
        let presenter = ProfilePresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }

    static func createOnboarding() -> UIViewController {
        OnboardingAssembly().build()
    }
    
    static func createAudioPlayer() -> UIViewController {
        AudioAssembly().build()
    }
}
