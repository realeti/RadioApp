//
//  AuthorizationPresenter.swift
//  RadioApp
//
//  Created by Мария Нестерова on 30.07.2024.
//

import Foundation

final class AuthorizationPresenter: AuthorizationPresenterProtocol {
    var view: (any AuthorizationControllerProtocol)?
    var router: (any AuthorizationRouterProtocol)?
    var mode: AuthorizationMode
    
    init(view: (any AuthorizationControllerProtocol)?, mode: AuthorizationMode) {
        self.mode = mode
    }

    func activate() {
        view?.update(with: .init(mode: mode))
    }
    
    func switchMode() {
        switch mode {
        case .signIn:
            mode = .signUp
        case .signUp:
            mode = .signIn
        }
        view?.update(with: .init(mode: mode))
    }
    
    func goToPopular() {
        view?.update(with: .init(mode: mode))
    }
    
    func didTapGoogleButton() {
        
    }
    
    func didTapForgotPasswordButton() {
        
    }
}
