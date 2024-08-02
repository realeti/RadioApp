//
//  AuthorizationRouter.swift
//  RadioApp
//
//  Created by Мария Нестерова on 30.07.2024.
//

import UIKit

final class AuthorizationRouter: Router, AuthorizationRouterProtocol {
    func goHome() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let windowDelegate = windowScene.delegate as? SceneDelegate {
            let vc = Builder.createTabBar()
            let window = windowDelegate.window
            window?.rootViewController = vc
        }
    }
    
    func showForgotPasswordVC() {
        let vc = Builder.createForgotPasswordVC(router: self)
        pushScreen(vc)
    }
    
    func showUpdatePasswordVC() {
        let vc = Builder.createUpdatePasswordVC(router: self)
        pushScreen(vc)
    }
    
    func proceedToSignIn() {
        controller?.navigationController?.popToRootViewController(animated: true)
    }
}
