//
//  AuthorizationProtocols.swift
//  RadioApp
//
//  Created by Мария Нестерова on 30.07.2024.
//

import UIKit

enum AuthorizationMode {
    case signIn
    case signUp
}

protocol AuthorizationControllerProtocol: AnyObject {
    func update(with model: AuthorizationController.Model)
}

protocol AuthorizationPresenterProtocol: AnyObject {
    func activate()
    func switchMode()
    func finishAuthorization()
    func didTapGoogleButton()
    func didTapForgotPasswordButton()
}

protocol AuthorizationRouterProtocol: AnyObject, Router {
    func showAuthorization(on window: UIWindow)
    func goHome()
    func showForgotPasswordVC()
    func showUpdatePasswordVC()
    func proceedToSignIn()
}
