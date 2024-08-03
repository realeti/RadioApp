//
//  UpdatePasswordPresenter.swift
//  RadioApp
//
//  Created by Мария Нестерова on 02.08.2024.
//

import UIKit

protocol UpdatePasswordPresenterProtocol {
    func activate()
    func updatePassword(password: String?)
}

final class UpdatePasswordPresenter: UpdatePasswordPresenterProtocol {
    weak var view: UpdatePasswordController?
    private var router: AuthorizationRouterProtocol?
    
    init(view: UpdatePasswordController, router: AuthorizationRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func updatePassword(password: String?) {
        router?.proceedToSignIn()
    }
    
    func activate() {
        view?.update(with: .init())
    }
}
