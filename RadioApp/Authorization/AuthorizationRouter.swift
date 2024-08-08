//
//  AuthorizationRouter.swift
//  RadioApp
//
//  Created by Мария Нестерова on 30.07.2024.
//

import UIKit

final class AuthorizationRouter: Router, AuthorizationRouterProtocol {
    private let builder: AuthorizationAssembly
    private let navigation: UINavigationController
    
    weak var root: RootRouter?
    
    init(builder: AuthorizationAssembly) {
        self.builder = builder
        self.navigation = UINavigationController()
        self.navigation.isNavigationBarHidden = true
    }
    
    func showAuthorization(on window: UIWindow) {
        let vc = builder.build(router: self, mode: .signIn)
        navigation.viewControllers = [vc]
        window.rootViewController = navigation
    }
    
    func reauthenticate(on router: Router) {
        let vc = builder.build(router: self, mode: .reauthenticate)
        navigation.modalPresentationStyle = .fullScreen
        navigation.viewControllers = [vc]
        router.presentScreen(navigation)
    }
    
    func goHome() {
        root?.startHome()
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
    
    func backToEditProfile() {
        navigation.dismiss(animated: true)
    }
}
