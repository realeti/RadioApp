//
//  ProfileAssembly.swift
//  RadioApp
//
//  Created by Мария Нестерова on 06.08.2024.
//

import UIKit

final class ProfileAssembly: ModuleAssembly {
    
    func build(router: ProfileRouterProtocol) -> UIViewController {
        let presenter = ProfilePresenter(router: router)
        let controller = ProfileViewController(presenter: presenter)
        presenter.view = controller
        router.controller = controller
        return controller
    }
}
