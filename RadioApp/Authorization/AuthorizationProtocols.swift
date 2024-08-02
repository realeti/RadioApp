//
//  AuthorizationProtocols.swift
//  RadioApp
//
//  Created by Мария Нестерова on 30.07.2024.
//

import Foundation

enum AuthorizationMode {
    case signIn
    case signUp
}

protocol AuthorizationControllerProtocol: AnyObject {
    func update(with model: AuthorizationController.Model)
}

protocol AuthorizationPresenterProtocol: AnyObject {
    var mode: AuthorizationMode { get set }
    func activate()
    func switchMode()
    func finishAuthorization()
    func didTapGoogleButton()
    func didTapForgotPasswordButton()
}

protocol AuthorizationRouterProtocol: AnyObject {
    func goHome()
    func showForgotPasswordVC()
    func showUpdatePasswordVC()
    func proceedToSignIn()
}
