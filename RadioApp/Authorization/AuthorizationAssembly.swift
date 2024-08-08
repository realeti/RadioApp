//
//  AuthorizationAssembly.swift
//  RadioApp
//
//  Created by Мария Нестерова on 30.07.2024.
//

import UIKit

final class AuthorizationAssembly {
    func build(router: AuthorizationRouterProtocol, mode: AuthorizationMode) -> UIViewController {
        let presenter = AuthorizationPresenter(mode: mode, router: router)
        let controller = AuthorizationController(presenter: presenter)
        presenter.view = controller
        router.controller = controller
        return controller
    }
}
