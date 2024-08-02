//
//  OnboardingAssembly.swift
//  RadioApp
//
//  Created by Мария Нестерова on 02.08.2024.
//

import UIKit

final class OnboardingAssembly: ModuleAssembly {
    func build() -> UIViewController {
        let controller = OnboardingController()
        let presenter = OnboardingPresenter()
        let router = OnboardingRouter()
        
        presenter.view = controller
        presenter.router = router
        controller.presenter = presenter
        router.controller = controller

        return controller
    }
}
