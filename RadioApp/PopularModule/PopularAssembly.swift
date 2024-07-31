//
//  PopularAssembly.swift
//  RadioApp
//
//  Created by realeti on 30.07.2024.
//

import UIKit

final class PopularAssembly: ModuleAssembly {
    func build() -> UIViewController {
        let viewController = PopularViewController()
        let router = PopularRouter()
        let presenter = PopularPresenter(view: viewController, router: router)

        viewController.presenter = presenter
        router.controller = viewController
        
        return viewController
    }
}
