//
//  HomeAssembly.swift
//  RadioApp
//
//  Created by Мария Нестерова on 06.08.2024.
//

import UIKit

final class HomeAssembly: ModuleAssembly {
    
    func build(router: HomeRouter) -> UIViewController {
        let presenter = HomePresenter(router: router)
        let controller = HomeController(presenter: presenter)
        presenter.view = controller
        
        return controller
    }
}
