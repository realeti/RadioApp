//
//  OnboardingRouter.swift
//  RadioApp
//
//  Created by Мария Нестерова on 02.08.2024.
//

import UIKit

protocol OnboardingRouterProtocol: AnyObject {
    func goToAutorization()
}

final class OnboardingRouter: Router, OnboardingRouterProtocol {
    private let builder: OnboardingAssembly
    
    weak var root: RootRouter?
    
    init(builder: OnboardingAssembly) {
        self.builder = builder
    }
    
    func showOnboarding(on window: UIWindow) {
        window.rootViewController = builder.build(router: self)
    }
    
    func goToAutorization() {
        root?.startAuthorization()
//        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//           let windowDelegate = windowScene.delegate as? SceneDelegate {
//            let vc = Builder.createAuthorization()
//            let window = windowDelegate.window
//            window?.rootViewController = vc
//        }
    }
}
