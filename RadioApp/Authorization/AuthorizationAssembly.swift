//
//  AuthorizationAssembly.swift
//  RadioApp
//
//  Created by Мария Нестерова on 30.07.2024.
//

import UIKit

final class AuthorizationAssembly: ModuleAssembly {
    func build(router: AuthorizationRouterProtocol) -> UIViewController {
        let presenter = AuthorizationPresenter(mode: .signIn, router: router)
        let controller = AuthorizationController(presenter: presenter)
        presenter.view = controller
        router.controller = controller
        return controller
    }
}
