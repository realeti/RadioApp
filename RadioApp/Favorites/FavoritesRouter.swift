//
//  FavoritesRouter.swift
//  RadioApp
//
//  Created by Natalia on 02.08.2024.
//

import Foundation

final class FavoritesRouter: Router, FavoritesRouterProtocol {
    func showDetails(with station: RadioStation) {
        let vc = StationDetailsAssembly().build(with: station)
        vc.hidesBottomBarWhenPushed = true
        vc.title = "Playing now"
        pushScreen(vc)
    }
}
