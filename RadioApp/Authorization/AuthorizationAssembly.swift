//
//  AuthorizationAssembly.swift
//  RadioApp
//
//  Created by Мария Нестерова on 30.07.2024.
//

import UIKit

final class AuthorizationAssembly: ModuleAssembly {
    
    func build(router: AuthorizationRouter) -> UIViewController {
        let controller = AuthorizationController()
        let presenter = AuthorizationPresenter(mode: .signIn)
        
        presenter.view = controller
        presenter.router = router
        controller.presenter = presenter
        router.controller = controller
        
//        let navVC = UINavigationController(rootViewController: controller)
//        navVC.isNavigationBarHidden = true
//    
//        return navVC
        
        return controller
    }
}
