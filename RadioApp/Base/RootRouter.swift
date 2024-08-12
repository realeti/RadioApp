//
//  RootRouter.swift
//  RadioApp
//
//  Created by Мария Нестерова on 06.08.2024.
//

import UIKit
import FirebaseAuth

final class RootRouter {
    private let window: UIWindow
    private let builder: RootBuilder

    init(_ window: UIWindow, builder: RootBuilder) {
        self.window = window
        self.builder = builder
    }

    deinit {
        print("im dead!")
    }

    func startFlow() {
        
        let loading = ViewController()
        loading.showLoading()
        window.rootViewController = loading
        window.makeKeyAndVisible()
        Auth.auth().addStateDidChangeListener { auth, user in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                if let user {
                    self?.startHome()
                } else {
                    let onboarding = self?.builder.buildOnboarding()
                    onboarding?.root = self
                    onboarding?.showOnboarding(on: self?.window ?? UIWindow())
                }
            }
        }
        
    }

    func startAuthorization() {
        let authorization = builder.buildAuthorization()
        authorization.root = self
        authorization.showAuthorization(on: window)
    }

    func startHome() {
        let home = builder.buildHome()
        home.root = self
        home.showHome(on: window)
    }
}
