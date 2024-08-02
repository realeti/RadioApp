//
//  ForgotPasswordPresenter.swift
//  RadioApp
//
//  Created by Мария Нестерова on 01.08.2024.
//

import Foundation

protocol ForgotPasswordPresenterProtocol {
    func activate()
    func requestUpdatePassword(email: String?)
}

final class ForgotPasswordPresenter: ForgotPasswordPresenterProtocol {
    weak var view: ForgotPasswordController?
    private var router: AuthorizationRouterProtocol?
    
    init(view: ForgotPasswordController, router: AuthorizationRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func requestUpdatePassword(email: String?) {
        router?.showUpdatePasswordVC()
    }
    
    func activate() {
        view?.update(with: .init())
    }
}
