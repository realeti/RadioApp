//
//  OnboardingAssembly.swift
//  RadioApp
//
//  Created by Мария Нестерова on 02.08.2024.
//

import UIKit

final class OnboardingAssembly {
    func build(router: OnboardingRouterProtocol) -> UIViewController {
        let presenter = OnboardingPresenter(router: router)
        let controller = OnboardingController(presenter: presenter)
        presenter.view = controller
        return controller
    }
}
