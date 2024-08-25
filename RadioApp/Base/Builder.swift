//
//  Builder.swift
//  RadioApp
//
//  Created by Мария Нестерова on 29.07.2024.
//

import UIKit

final class Builder {
    static func createPopular() -> UIViewController {
        PopularAssembly().build(router: PopularRouter())
    }

    static func createFavorite() -> UIViewController {
        FavoritesAssembly().build(router: FavoritesRouter())
    }

    static func createAllStations() -> UIViewController {
        let navigation = NavigationController()
        let builder = AllStationsAssembly()
        let router = AllStationsRouter(builder: builder, navigation: navigation)
        router.showAllStations()
        return navigation
    }
    
    static func createProfile() -> UIViewController {
        ProfileAssembly.build(router: ProfileRouter())
    }
    
    static func createAudioPlayer() -> UIViewController {
        AudioAssembly().build()
    }
}
