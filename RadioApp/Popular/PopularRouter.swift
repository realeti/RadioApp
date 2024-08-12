//
//  PopularRouter.swift
//  RadioApp
//
//  Created by realeti on 30.07.2024.
//

import Foundation

protocol PopularRouterProtocol: AnyObject, Router {
    func showDetail(with station: RadioStation)
}

final class PopularRouter: Router, PopularRouterProtocol {
    func showDetail(with station: RadioStation) {
        let vc = StationDetailsAssembly().build(with: station)
        vc.title = "Playing now"
        pushScreen(vc)
    }
}
