//
//  PopularAssembly.swift
//  RadioApp
//
//  Created by realeti on 30.07.2024.
//

import UIKit

#warning("Why class?")
final class PopularAssembly: ModuleAssembly {
    func build(router: PopularRouterProtocol) -> UIViewController {
        let presenter = PopularPresenter(router: router)
        let controller = PopularViewController(presenter: presenter)
        
        presenter.view = controller
        router.controller = controller
        
        return controller
    }
}

