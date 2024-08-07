//
//  OnboardingPresenter.swift
//  RadioApp
//
//  Created by Мария Нестерова on 02.08.2024.
//

import Foundation

protocol OnboardingPresenterProtocol {
    func goToAutorization()
}

final class OnboardingPresenter: OnboardingPresenterProtocol {
    weak var view: OnboardingController?
    private let router: OnboardingRouterProtocol
    
    init(router: OnboardingRouterProtocol) {
        self.router = router
    }
    
    func goToAutorization() {
        router.goToAutorization()
    }
}
