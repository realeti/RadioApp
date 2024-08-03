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
    func goToAutorization() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let windowDelegate = windowScene.delegate as? SceneDelegate {
            let vc = Builder.createAuthorization()
            let window = windowDelegate.window
            window?.rootViewController = vc
        }
    }
}
