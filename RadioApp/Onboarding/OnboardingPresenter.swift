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
    var view: OnboardingController?
    var router: (any OnboardingRouterProtocol)?
    
    func goToAutorization() {
        router?.goToAutorization()
    }
}
