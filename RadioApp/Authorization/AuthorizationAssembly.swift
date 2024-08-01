//
//  AuthorizationAssembly.swift
//  RadioApp
//
//  Created by Мария Нестерова on 30.07.2024.
//

import UIKit

final class AuthorizationAssembly: ModuleAssembly {
    func build() -> UIViewController {
        let controller = AuthorizationController()
        let presenter = AuthorizationPresenter(view: controller, mode: .signIn)
        let router = AuthorizationRouter()
        
        presenter.view = controller
        presenter.router = router
        controller.presenter = presenter
        router.controller = controller
        
        controller.hidesBottomBarWhenPushed = true
        
        return controller
    }
}
