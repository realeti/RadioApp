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
    
    init(mode: AuthorizationMode) {
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
    
    func finishAuthorization() {
        switch mode {
        case .signIn:
            switch signIn() {
            case .success(true):
                print("successfully signeded in")
                router?.goHome()
            case .success(false):
                print("can't sign in")
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        case .signUp:
            switch signUp() {
            case .success(true):
                print("successfully signed up")
                router?.goHome()
            case .success(false):
                print("can't sign up")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    private func signIn() -> Result<Bool, Error> {
        return .success(true)
    }
    
    private func signUp() -> Result<Bool, Error> {
        return .success(true)
    }
    
    func didTapGoogleButton() {
        
    }
    
    func didTapForgotPasswordButton() {
        router?.showForgotPasswordVC()
    }
}
