//
//  FavoritesAssembly.swift
//  RadioApp
//
//  Created by Natalia on 02.08.2024.
//

import UIKit

final class FavoritesAssembly: ModuleAssembly {
    func build() -> UIViewController {
        let controller = FavoritesController()
        let presenter = FavoritesPresenter()
        let router = FavoritesRouter()
        controller.presenter = presenter
        presenter.view = controller
        presenter.router = router
        router.controller = controller
        return controller
    }
}
