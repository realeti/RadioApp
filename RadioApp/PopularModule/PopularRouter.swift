//
//  PopularRouter.swift
//  RadioApp
//
//  Created by realeti on 30.07.2024.
//

import Foundation

protocol PopularRouterProtocol: AnyObject {
    func showDetails()
}

final class PopularRouter: Router, PopularRouterProtocol {
    func showDetails() {
        let detailsVC = Builder.createDetails()
        pushScreen(detailsVC)
    }
}
