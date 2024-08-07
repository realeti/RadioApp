//
//  OnboardingRouter.swift
//  RadioApp
//
//  Created by Мария Нестерова on 02.08.2024.
//

import UIKit

protocol OnboardingRouterProtocol: AnyObject, Router {
    func goToAutorization()
}

final class OnboardingRouter: Router, OnboardingRouterProtocol {
    private let builder: OnboardingAssembly
    
    weak var root: RootRouter?
    
    init(builder: OnboardingAssembly) {
        self.builder = builder
    }
    
    func showOnboarding(on window: UIWindow) {
        window.rootViewController = builder.build(router: self)
    }
    func goToAutorization() {
        root?.startAuthorization()
    }
}
