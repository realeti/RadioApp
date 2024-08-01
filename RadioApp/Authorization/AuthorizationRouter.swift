//
//  AuthorizationRouter.swift
//  RadioApp
//
//  Created by Мария Нестерова on 30.07.2024.
//

import UIKit

final class AuthorizationRouter: Router, AuthorizationRouterProtocol {
    func showAuthorizationVC() {
        let vc = Builder.createAuthorization()
        pushScreen(vc)
    }
    
    func showForgotPasswordVC() {
//        let vc = Builder.createForgotPassword()
//        pushScreen(vc)
    }
    
    func showUpdatePasswordVC() {
//        let vc = Builder.createUpdatePassword()
//        pushScreen(vc)
    }
}
