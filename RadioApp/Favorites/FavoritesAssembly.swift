//
//  FavoritesAssembly.swift
//  RadioApp
//
//  Created by Natalia on 02.08.2024.
//

import UIKit

final class FavoritesAssembly {
    
    func build(router: FavoritesRouter) -> UIViewController {
        let presenter = FavoritesPresenter(router: router)
        let controller = FavoritesController(presenter: presenter)
        presenter.view = controller
        router.controller = controller
        return controller
    }
}
